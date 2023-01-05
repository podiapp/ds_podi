part of '../utils.dart';

///Contem as cores e tonalidades principais do Podi
///
///Aplica instancias de [MaterialColor] e [Color]
///
///No caso das [MaterialColor], para acessar as tonalidades das cores é necessário chamá-las da seguinte forma:
///```dart
///PodiColors.dark[500]!
///```
///Com null safety pode ser necessário adicionar o "!", para isso confirmar a existência da tonalidade requerida.
///
///A tonalidade principal pode ser chamada sem os colchetes, assim como as [Color], e sem a necessidade do operador "!". Exemplo:
///```dart
///PodiColors.green
///```
class PodiColors {
  PodiColors._();

  /// ### Verde
  ///Principal tonalidade **500**
  static const MaterialColor green = const MaterialColor(
    0xFF48DB84,
    const {
      50: Color(0xFFE5FAEE),
      100: Color(0xFFDAF8E6),
      200: Color(0xFFA3EDC1),
      300: Color(0xFF85E7AD),
      400: Color(0xFF67E198),
      500: Color(0xFF48DB84),
      600: Color(0xFF3CB66E),
      700: Color(0xFF309258),
      800: Color(0xFF246E42),
      900: Color(0xFF18492C),
    },
  );

  /// ### Preto
  ///Principal tonalidade **900**
  static const MaterialColor dark = const MaterialColor(
    0xFF393C47,
    const {
      50: Color(0xFFF2F3F7),
      100: Color(0xFFE1E3EE),
      300: Color(0xFFBDC1D9),
      500: Color(0xFF8C90A5),
      900: Color(0xFF393C47),
    },
  );

  /// ### Branco
  static const Color white = Colors.white;

  /// ### Vermelho (Perigo)
  ///Principal tonalidade **600**
  static const MaterialColor danger = const MaterialColor(
    0xFFF13A37,
    const {
      200: Color(0xFFFEECEC),
      300: Color(0xFFFCD9D9),
      400: Color(0xFFF89896),
      500: Color(0xFFF46765),
      600: Color(0xFFF13A37),
    },
  );

  /// ### Amarelo (Aviso)
  ///Principal tonalidade **600**
  static const MaterialColor warning = const MaterialColor(
    0xFFFFC618,
    const {
      200: Color(0xFFFFF7E0),
      300: Color(0xFFFFEDB8),
      400: Color(0xFFFFE080),
      500: Color(0xFFFFC618),
      600: Color(0xFFFFC618),
    },
  );

  /// ### Laranja (Descontos)
  ///Principal tonalidade **500**
  static const MaterialColor discounts = const MaterialColor(
    0xFFFF5630,
    const {
      50: Color(0xFFfAE9E8),
      100: Color(0xFFFECCBF),
      500: Color(0xFFFF5630),
    },
  );

  /// ### Neutrals
  ///Principal tonalidade **700**
  static const MaterialColor neutrals = const MaterialColor(
    0xFF626275,
    const {
      50: Color(0xFFF8F8FD),
      100: Color(0xFFEDEDF7),
      200: Color(0xFFD6D6E6),
      300: Color(0xFFBDBDD0),
      400: Color(0xFFA5A5B9),
      500: Color(0xFF8E8EA2),
      600: Color(0xFF78788C),
      700: Color(0xFF626275),
      800: Color(0xFF393C47),
      900: Color(0xFF1F2128),
    },
  );

  /// ### Azul
  ///Principal tonalidade **600**
  static const MaterialColor blue = const MaterialColor(
    0xFF0587D6,
    const {
      200: Color(0xFFEBF7FF),
      300: Color(0xFFC8E9FE),
      400: Color(0xFF8CD2FC),
      500: Color(0xFF50BAFB),
      600: Color(0xFF0587D6),
    },
  );

  /// ### Roxo
  ///Principal tonalidade **500**
  static const MaterialColor purple = const MaterialColor(
    0xFFA23EF0,
    const {
      50: Color(0xFFF6ECFE),
      100: Color(0xFFEAD4FC),
      200: Color(0xFFD6AAF8),
      300: Color(0xFFC17EF5),
      400: Color(0xFFB15EF2),
      500: Color(0xFFA23EF0),
      600: Color(0xFF8734C8),
      700: Color(0xFF6C29A0),
      800: Color(0xFF511F78),
      900: Color(0xFF361550),
    },
  );
}
