part of '../utils.dart';

///Variável de log
///
///Possui as opcões:
/// - Verbose [log.v("")],
/// - Debug [log.d("")],
/// - Info [log.i("")],
/// - Warning [log.w("")],
/// - Error [log.e("")],
/// - WTF! [log.wtf("")],
///
///Deve ser utilizada da seguinte forma
///```dart
///log.d("<LUGAR_DO_LOG> MENSAGEM")
///```
///Onde LUGAR_DO_LOG é a classe ou funcionalidade que o chama
final log = Logger(
  printer: CustomPrinter(),
  level: Level.verbose,
  filter: CustomFilter(),
);

///Texto com todos os log para debug
String logString = "";

///Filtro de Log para ativar o Logger em Produção
class CustomFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => true;
}

///Printa o log com cores e prefixos específicos baseado no nível do log
class CustomPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    var color = {
      Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
      Level.debug: AnsiColor.fg(6),
      Level.info: AnsiColor.fg(2),
      Level.warning: AnsiColor.fg(3),
      Level.error: AnsiColor.fg(196),
      Level.wtf: AnsiColor.fg(199),
    }[event.level]!;
    var prefix = {
      Level.verbose: "[VERB]",
      Level.debug: "[DEBG]",
      Level.info: "[INFO]",
      Level.warning: "[WARN]",
      Level.error: "[ERR!]",
      Level.wtf: "[WTF!]",
    }[event.level];

    String result = '$prefix ${event.message}';
    logString += "  $result\n";
    return [color(result)];
  }
}
