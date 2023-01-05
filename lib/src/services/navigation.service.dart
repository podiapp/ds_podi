import 'package:flutter/widgets.dart';

import '../utils.dart';

/// Serviço de navegação entre páginas
///
/// Funciona como um [Navigator], porém sem a necessidade de ter um [BuildContext]
class NavigationService extends NavigatorObserver {
  ///Função que executa quando a página for alterada, seja por pop ou push
  final void Function()? onPageChanged;

  ///Verifica se a rota com os argumentos deve ser chamada com [pushAsFirst(pageUrl)]
  ///Caso sim, deve retornar [true]
  final bool Function(String pageUrl, [dynamic argument])? checkIsRouteRoot;

  final Function(Uri page)? handleUriPage;

  ///Página principal para retornar quando não tiver mais para onde ir
  final String homePage;

  NavigationService(
      {this.homePage = "/", this.handleUriPage, this.onPageChanged, this.checkIsRouteRoot});

  ///Chave que representa o [Navigator]
  ///
  ///Para acessá-lo pode ser feito:
  ///```dart
  ///navigatorKey.currentState
  ///```
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Uri? _linkPage;

  ///Adiciona um "Checkpoint" de DynamicLink através do [page]
  void setLink(Uri? page) => _linkPage = page;

  ///Verifica se tem um DynamicLink esperando para ser aberto
  bool hasLink() => _linkPage != null;

  ///Abre o DynamicLink ativo e o reseta.
  ///
  ///O [replace] serve para verificar se a página atual deve ser ou não substituida pelo link
  Future<dynamic>? pushLink([bool replace = true]) {
    final p = _linkPage;
    setLink(null);
    if (replace) pop();
    if (p != null) return handleUriPage!(p);
    return null;
  }

  String? _checkpointPage;
  dynamic _checkpointArgument;

  /// Adiciona um "Checkpoint" ao servico, facilitando o retorno à página
  void setCheckpoint(String? page, [dynamic argument]) {
    _checkpointPage = page;
    _checkpointArgument = argument;
  }

  /// Verifica a existência de um checkpoint ativo
  bool hasCheckpoint() => _checkpointPage != null;

  /// Vai ao último checkpoint ativo e o reseta
  Future<dynamic>? pushCheckpoint([bool replace = true]) {
    if (!hasCheckpoint()) return null;
    final p = _checkpointPage;
    final a = _checkpointArgument;
    setCheckpoint(null, null);
    if (replace) return pushReplacement(p!, arguments: a);
    return push(p!, arguments: a);
  }

  /// Atalho para aplicar o [checkIsRouteRoot] com null safety
  bool checkRoute(String pageUrl, [dynamic arguments]) {
    if (checkIsRouteRoot == null) return false;
    return checkIsRouteRoot!(pageUrl, arguments);
  }

  /// Equivalente a [Navigator.pushReplacementNamed(context, routeName)] sem o [BuildContext]
  Future<dynamic>? pushReplacement(String pageUrl, {dynamic arguments, dynamic result}) {
    if (checkRoute(pageUrl, arguments)) return pushAsFirst(pageUrl, arguments: arguments);
    if (onPageChanged != null) onPageChanged!();
    return navigatorKey.currentState!
        .pushReplacementNamed(pageUrl, arguments: arguments, result: result);
  }

  /// Equivalente a [Navigator.pushNamed(context, routeName)] sem o [BuildContext]
  Future<dynamic>? push(String pageUrl, {dynamic arguments}) {
    if (checkRoute(pageUrl, arguments)) return pushAsFirst(pageUrl, arguments: arguments);
    if (onPageChanged != null) onPageChanged!();
    return navigatorKey.currentState!.pushNamed(pageUrl, arguments: arguments);
  }

  /// Equivalente a [Navigator.maybePop(context)] sem o [BuildContext]
  ///
  /// Caso [force] seja [true] -> Equivalente a [Navigator.pop(context)] sem o [BuildContext]
  void pop([dynamic result, bool force = false]) {
    log.i("<Router> Pop Page");
    if (canPop()) {
      if (onPageChanged != null) onPageChanged!();
      if (force)
        navigatorKey.currentState!.pop(result);
      else
        navigatorKey.currentState!.maybePop(result);
    } else {
      navigatorKey.currentState!.pushReplacementNamed(homePage, result: result);
    }
  }

  /// Get the name of the current route
  String currentPath = "/";

  /// Take current route arguments
  dynamic currentArguments;

  /// Remove todas as páginas da pilha e adiciona a [pageUrl] no topo
  Future<dynamic> pushAsFirst(String pageUrl, {dynamic arguments}) {
    while (canPop()) {
      navigatorKey.currentState!.pop();
    }
    if (currentPath == pageUrl && currentArguments == arguments) {
      return Future.value(null);
    }
    return navigatorKey.currentState!.pushReplacementNamed(pageUrl, arguments: arguments);
  }

  /// Equivalente a [Navigator.canPop(context)] sem o [BuildContext]
  bool canPop() => navigatorKey.currentState!.canPop();

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    log.i("<Router> Pop Page");
    currentPath = previousRoute?.settings.name ?? currentPath;
    currentArguments = previousRoute?.settings.arguments;
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    currentPath = route.settings.name ?? currentPath;
    currentArguments = route.settings.arguments;
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    currentPath = previousRoute?.settings.name ?? currentPath;
    currentArguments = previousRoute?.settings.arguments;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    currentPath = newRoute?.settings.name ?? currentPath;
    currentArguments = newRoute?.settings.arguments;
  }
}
