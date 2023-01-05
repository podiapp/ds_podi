part of "../utils.dart";

/// O tema principal dos serviços do PODI. Aqui é onde se armazena todas as cores e estilos característicos utilizados nos aplicativos da PODI.
ThemeData podiThemeData(BuildContext context) => ThemeData(
      textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      fontFamily: PodiTexts.fontFamily,
      primaryColor: PodiColors.green,
      backgroundColor: PodiColors.dark[50],
      unselectedWidgetColor: PodiColors.dark[300],
      appBarTheme: AppBarTheme(
        color: PodiColors.white,
        titleTextStyle: PodiTexts.body1.withColor(PodiColors.green),
        toolbarTextStyle: PodiTexts.caption.withColor(PodiColors.white),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(PodiColors.white),
        fillColor: MaterialStateProperty.all(PodiColors.green),
        side: BorderSide(color: PodiColors.dark[100]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: PodiColors.dark[100]!),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(PodiColors.green),
      ),
      colorScheme: ColorScheme(
        background: PodiColors.dark[50]!,
        onBackground: PodiColors.dark,
        brightness: Brightness.light,
        error: PodiColors.danger,
        onError: PodiColors.white,
        surface: PodiColors.white,
        onSurface: PodiColors.dark,
        primary: PodiColors.green,
        onPrimary: PodiColors.white,
        secondary: PodiColors.green,
        onSecondary: PodiColors.white,
      ).copyWith(secondary: PodiColors.green),
    );

/// Decoração básica para botões do PODI.
class BasicButtonStyle extends ButtonStyle {
  BasicButtonStyle({
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? disabledColor,
    Color? foregroundColor,
    Color? overlayColor,
    Color? shadowColor,
    double? elevation,
    EdgeInsets? padding,
    Size? minimumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? mouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    Alignment? alignment,
  }) : super(
          textStyle: MaterialStateProperty.all(textStyle),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (disabledColor != null && states.contains(MaterialState.disabled))
              return disabledColor;
            return backgroundColor;
          }),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
          overlayColor: MaterialStateProperty.all(overlayColor),
          shadowColor: MaterialStateProperty.all(shadowColor),
          elevation: MaterialStateProperty.all(elevation),
          padding: MaterialStateProperty.all(padding),
          minimumSize: MaterialStateProperty.all(minimumSize),
          side: MaterialStateProperty.all(side),
          shape: MaterialStateProperty.all(shape),
          mouseCursor: MaterialStateProperty.all(mouseCursor),
          visualDensity: visualDensity,
          tapTargetSize: tapTargetSize,
          animationDuration: animationDuration,
          enableFeedback: enableFeedback,
          alignment: alignment,
        );
}

/// Decoração para TextFields padrão do PODI.
class InputDecorationWidget {
  static InputDecoration simple({
    String hint = "",
    String? error,
    Widget? prefix,
    Widget? suffix,
    Color? backgroundColor,
    Color? borderColor,
    double? radius,
  }) {
    return InputDecoration(
      filled: true,
      alignLabelWithHint: true,
      fillColor: backgroundColor ?? PodiColors.dark[50],
      contentPadding: EdgeInsets.all(16.0),
      hintText: hint,
      errorText: error,
      counterStyle: PodiTexts.theme(height: double.minPositive, color: PodiColors.dark[500]),
      counterText: "",
      prefixIcon: prefix,
      suffixIcon: suffix != null
          ? suffix
          : error != null
              ? Padding(
                  padding: EdgeInsetsDirectional.only(top: 12, bottom: 12, end: 12, start: 12),
                  child: Icon(
                    PodiIcons.podi,
                    color: PodiColors.dark[300],
                    size: 16.0,
                  ),
                )
              : null,
      hintStyle: PodiTexts.theme(color: PodiColors.dark[500], fontSize: 15),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? PodiColors.dark[50]!),
        borderRadius: BorderRadius.circular(radius ?? 4.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? PodiColors.dark[50]!),
        borderRadius: BorderRadius.circular(radius ?? 4.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? PodiColors.dark[50]!),
        borderRadius: BorderRadius.circular(radius ?? 4.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: PodiColors.danger),
        borderRadius: BorderRadius.circular(radius ?? 4.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: PodiColors.danger),
        borderRadius: BorderRadius.circular(radius ?? 4.0),
      ),
      errorStyle:
          PodiTexts.theme(color: PodiColors.danger, fontWeight: FontWeight.w600, fontSize: 10),
    );
  }

  static InputDecoration build(String hint, String? error, {Widget? suffixIcon, int? hintLines}) {
    return InputDecoration(
      filled: true,
      alignLabelWithHint: true,
      hintMaxLines: hintLines,
      fillColor: error != null ? PodiColors.white : PodiColors.dark[50],
      contentPadding: EdgeInsets.all(16.0),
      hintText: hint,
      errorText: error,
      counterStyle: PodiTexts.theme(height: double.minPositive, color: PodiColors.dark[500]),
      counterText: "",
      suffixIcon: suffixIcon != null
          ? suffixIcon
          : error != null
              ? Padding(
                  padding: EdgeInsetsDirectional.only(top: 12, bottom: 12, end: 12, start: 12),
                  child: Icon(
                    PodiIcons.podi,
                    color: PodiColors.dark[300],
                    size: 17.0,
                  ),
                )
              : null,
      hintStyle: PodiTexts.theme(color: PodiColors.dark[500], fontSize: 15.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: PodiColors.dark[50]!),
        borderRadius: BorderRadius.circular(4.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: PodiColors.dark[50]!),
        borderRadius: BorderRadius.circular(4.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: PodiColors.dark[50]!),
        borderRadius: BorderRadius.circular(4.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: PodiColors.danger),
        borderRadius: BorderRadius.circular(4.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: PodiColors.danger),
        borderRadius: BorderRadius.circular(4.0),
      ),
      errorStyle:
          PodiTexts.theme(color: PodiColors.danger, fontWeight: FontWeight.w600, fontSize: 10.0),
    );
  }
}
