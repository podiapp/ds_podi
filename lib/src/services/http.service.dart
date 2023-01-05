import 'dart:io';

import '../utils.dart';

///Serviço para requisições http
///
///Utiliza o pacote [Dio] para tratar as requisições com [InterceptorsWrapper] para interceptar as requisições
class HttpService {
  final Dio dio = Dio();

  ///Inicia os Interceptadores
  ///
  ///- [onRequest] -> Ativado ao início de cada requisição http
  ///
  ///- [onResponse] -> Ativado ao receber uma resposta de uma requisição http
  ///
  ///- [on401Error] -> Ativado ao receber uma resposta 401 (Unauthorized)
  ///    - Recomenda-se atualizar o token do usuário e refazer a requisição através do [DioError.requestOptions]
  ///    - É importante esperar um tempo desde a última execução da função para evitar loops infinitos
  ///
  ///- [onSocketException] -> Ativado ao receber um Socket Exception (Sem conexão com internet)
  ///    - Recomenda-se verificar cache, caso exista, antes de tomar alguma ação
  ///    - Uma solução possível é executar um [Navigator.push()] para uma página com uma mensagem amigável
  /// e só rodar [Navigator.pop()] ao confirmar a existência de conexão com internet,
  /// depois retentar a requisição através do [DioError.requestOptions]
  ///
  HttpService({
    void Function(RequestOptions, RequestInterceptorHandler)? onRequest,
    void Function(Response<dynamic>, ResponseInterceptorHandler)? onResponse,
    void Function(DioError, ErrorInterceptorHandler)? on401Error,
    void Function(DioError, ErrorInterceptorHandler)? onSocketException,
    void Function(DioError, ErrorInterceptorHandler)? onError,
  }) {
    void _onError(DioError error, ErrorInterceptorHandler handler) async {
      if (error.response?.data != null) error.response!.data = error.response!.data.toString();
      if (error.response?.statusCode == 401) {
        log.w("<Http> Error 401 - User token may be expired");
        if (on401Error != null) on401Error(error, handler);
      }

      if (error.error is SocketException) {
        log.e("<Dio> NO INTERNET CONNECTION");
        if (onSocketException != null) onSocketException(error, handler);
      }

      if (error.response == null || [500].contains(error.response!.statusCode)) {
        if (onError != null) onError(error, handler);
        handler.next(error);
      } else {
        handler.resolve(error.response!);
      }
    }

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: onRequest,
      onResponse: onResponse,
      onError: _onError,
    ));
  }
}
