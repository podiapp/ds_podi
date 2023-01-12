part of "../utils.dart";

/// Classe onde se armazena todas as constantes da API utilizada nos serviços PODI.
class ApiConstants {
  /// Nessa variável, se armazena qual `environment` está sendo utilizada.
  static const _env = String.fromEnvironment("ENV");

  static ENV get env {
    switch (_env) {
      case "dev":
        return ENV.DEVELOPMENT;
      case "sb":
        return ENV.SANDBOX;
      default:
        return ENV.PRODUCTION;
    }
  }

  static const suffix = _env != "" ? "-$_env" : "";
  //APIs
  /// API de Configurações do Aplicativo
  ///
  /// https://appsettings-sb.podiapp.com.br/swagger/index.html \
  /// https://appsettings-dev.podiapp.com.br/swagger/index.html \
  /// https://appsettings.podiapp.com.br/swagger/index.html
  static const String API_SETTINGS =
      "https://appsettings$suffix.podiapp.com.br/api/";

  static const String API_WORKSHOP =
      "https://7rnomuabhmyqva5yx6eulafpee0dvjch.lambda-url.us-east-1.on.aws/api/";
}

enum ENV { DEVELOPMENT, SANDBOX, PRODUCTION }

extension ENV_STRING on ENV {
  String get name {
    switch (this) {
      case ENV.DEVELOPMENT:
        return "development";
      case ENV.PRODUCTION:
        return "production";
      case ENV.SANDBOX:
        return "sandbox";
    }
  }
}
