part of "../utils.dart";

extension TextStyleExtension on TextStyle {
  ///height: 1
  TextStyle get heightCenter => this.copyWith(height: 1);

  ///height: 1.2
  TextStyle get heightCompact => this.copyWith(height: 1.2);

  ///height: 1.5
  TextStyle get heightRegular => this.copyWith(height: 1.5);

  ///height: 1.7
  TextStyle get heightMedium => this.copyWith(height: 1.7);

  ///height: 2
  TextStyle get heightLong => this.copyWith(height: 2);

  ///fontWeight: w800
  TextStyle get weightExtraBold => this.copyWith(fontWeight: FontWeight.w800);

  ///fontWeight: w700
  TextStyle get weightBold => this.copyWith(fontWeight: FontWeight.w700);

  ///fontWeight: w600
  TextStyle get weightSemibold => this.copyWith(fontWeight: FontWeight.w600);

  ///fontWeight: w500
  TextStyle get weightMedium => this.copyWith(fontWeight: FontWeight.w500);

  ///fontWeight: w400
  TextStyle get weightRegular => this.copyWith(fontWeight: FontWeight.w400);

  ///spacing: 0
  TextStyle get spacingRegular => this.copyWith(letterSpacing: 0);

  ///spacing: 0.6
  TextStyle get spacingMedium => this.copyWith(letterSpacing: 0.6);

  ///spacing: 1
  TextStyle get spacingExtend => this.copyWith(letterSpacing: 1);

  ///fontSize: 11
  TextStyle get sizeXXSmall => this.copyWith(fontSize: 11);

  ///fontSize: 12
  TextStyle get sizeXSmall => this.copyWith(fontSize: 12);

  ///fontSize: 13
  TextStyle get sizeSmall => this.copyWith(fontSize: 13);

  ///fontSize: 16
  TextStyle get sizeDefault => this.copyWith(fontSize: 16);

  ///fontSize: 19
  TextStyle get sizeMedium => this.copyWith(fontSize: 19);

  ///fontSize: 24
  TextStyle get sizeLarge => this.copyWith(fontSize: 24);

  ///fontSize: 32
  TextStyle get sizeXLarge => this.copyWith(fontSize: 32);

  ///fontSize: 40
  TextStyle get sizeXXLarge => this.copyWith(fontSize: 40);

  ///fontSize: 48
  TextStyle get sizeXXXLarge => this.copyWith(fontSize: 48);

  ///fontSize: 56
  TextStyle get sizeXXXXLarge => this.copyWith(fontSize: 56);

  /// Função para trocar a cor da fonte escolhida.
  ///
  /// Exemplo:
  /// ```dart
  /// PodiTexts.body1.withColor(PodiColors.green);
  /// ```
  TextStyle withColor(Color color) => this.copyWith(color: color);

  /// Função para trocar o Tamanho escolhida.
  ///
  /// Exemplo:
  /// ```dart
  /// PodiTexts.body1.size(14);
  /// ```
  TextStyle size(double value) => this.copyWith(fontSize: value);

  /// Função para trocar o `height` da fonte escolhida.
  ///
  /// Exemplo:
  /// ```dart
  /// PodiTexts.body1.withHeight(1.5);
  /// ```
  TextStyle withHeight(double value) => this.copyWith(height: value);
}

///Contém as fontes principais do Podi
class PodiTexts {
  static const fontFamily = "packages/ds_podi/Montserrat";
  static TextStyle theme({
    Color? color,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      color: color ?? PodiColors.neutrals[800],
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// Características da fonte:
  ///
  /// * Tamanho: 48
  /// * Peso: w500
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle heading1 =
      theme().sizeXXXLarge.weightMedium.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 40
  /// * Peso: w500
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle heading2 =
      theme().sizeXXLarge.weightMedium.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 32
  /// * Peso: w500
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle heading3 =
      theme().sizeXLarge.weightMedium.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 28
  /// * Peso: w500
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle heading4 = theme().size(28).heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 24
  /// * Peso: w500
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle heading5 =
      theme().sizeLarge.weightMedium.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 20
  /// * Peso: w500
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle heading6 =
      theme().size(20).weightMedium.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 16
  /// * Peso: w500
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle heading7 =
      theme().sizeDefault.weightMedium.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 19
  /// * Peso: w600
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle title =
      theme().sizeMedium.weightSemibold.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 16
  /// * Peso: w600
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle subtitle1 =
      theme().sizeDefault.weightSemibold.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 14
  /// * Peso: w600
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle subtitle2 =
      theme().sizeSmall.weightSemibold.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 16
  /// * Peso: w400
  /// * Altura: 1.5
  /// * Espaçamento: 0
  static TextStyle body1 =
      theme().sizeDefault.weightRegular.heightRegular.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 13
  /// * Peso: w400
  /// * Altura: 1.5
  /// * Espaçamento: 0
  static TextStyle body2 =
      theme().sizeSmall.weightRegular.heightRegular.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 16
  /// * Peso: w400
  /// * Altura: 1.0
  /// * Espaçamento: 0
  static TextStyle label1 =
      theme().sizeDefault.weightRegular.heightCenter.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 13
  /// * Peso: w400
  /// * Altura: 1.0
  /// * Espaçamento: 0
  static TextStyle label2 =
      theme().sizeSmall.weightRegular.heightCenter.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 11
  /// * Peso: w400
  /// * Altura: 1.0
  /// * Espaçamento: 0
  static TextStyle label3 =
      theme().sizeXXSmall.weightRegular.heightCenter.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 12
  /// * Peso: w500
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle caption =
      theme().sizeXSmall.weightMedium.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 10
  /// * Peso: w600
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle overline =
      theme().sizeXXSmall.weightSemibold.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 14
  /// * Peso: w600
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle button1 =
      theme().sizeSmall.weightSemibold.heightCompact.spacingRegular;

  /// Características da fonte:
  ///
  /// * Tamanho: 12
  /// * Peso: w600
  /// * Altura: 1.2
  /// * Espaçamento: 0
  static TextStyle button2 =
      theme().sizeXSmall.weightSemibold.heightCompact.spacingRegular;
}
