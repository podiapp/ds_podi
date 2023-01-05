import 'package:flutter/material.dart';

import '../utils.dart';

enum ButtonSize { large, medium, small, tiny }

class PodiButton {
  static theme({
    required Color backgroundColor,
    required Color color,
    Color? borderColor,
    Color? hoverColor,
    Color? splashColor,
    String? title,
    IconData? icon,
    Function()? onTap,
    ButtonSize size = ButtonSize.medium,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
  }) {
    EdgeInsets getPadding() {
      switch (size) {
        case ButtonSize.large:
          if (title != null) {
            if (icon != null) {
              if (controlAffinity == ListTileControlAffinity.leading) {
                return const EdgeInsets.fromLTRB(12, 12, 20, 12);
              } else {
                return const EdgeInsets.fromLTRB(20, 12, 12, 12);
              }
            }
            return const EdgeInsets.symmetric(vertical: 13, horizontal: 20);
          }
          return const EdgeInsets.all(12);
        case ButtonSize.medium:
          if (title != null) {
            if (icon != null) {
              if (controlAffinity == ListTileControlAffinity.leading) {
                return const EdgeInsets.fromLTRB(12, 12, 20, 12);
              } else {
                return const EdgeInsets.fromLTRB(20, 12, 12, 12);
              }
            }
            return const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
          }
          return const EdgeInsets.all(12);
        case ButtonSize.small:
          if (title != null) {
            if (icon != null) {
              if (controlAffinity == ListTileControlAffinity.leading) {
                return const EdgeInsets.fromLTRB(12, 6, 16, 6);
              } else {
                return const EdgeInsets.fromLTRB(16, 6, 12, 6);
              }
            }
            return const EdgeInsets.symmetric(vertical: 10, horizontal: 16);
          }
          return const EdgeInsets.all(12);
        case ButtonSize.tiny:
          if (title != null) {
            if (icon != null) {
              if (controlAffinity == ListTileControlAffinity.leading) {
                return const EdgeInsets.fromLTRB(8, 8, 12, 8);
              } else {
                return const EdgeInsets.fromLTRB(12, 8, 8, 8);
              }
            }
            return const EdgeInsets.symmetric(vertical: 8, horizontal: 12);
          }
          return const EdgeInsets.all(8);
      }
    }

    Widget? getIcon() {
      if (icon == null) {
        return null;
      }
      switch (size) {
        case ButtonSize.large:
          return Icon(icon, size: 20, color: color);
        case ButtonSize.medium:
          return Icon(icon, size: 18, color: color);
        case ButtonSize.small:
          return Icon(icon, size: 16, color: color);
        case ButtonSize.tiny:
          return Icon(icon, size: 14, color: color);
      }
    }

    Widget? getText() {
      if (isNull(title)) {
        return null;
      }
      switch (size) {
        case ButtonSize.large:
          return Text(
            title!,
            style: PodiTexts.label1.weightBold.withColor(color),
          );
        case ButtonSize.medium:
          return Text(
            title!,
            style: PodiTexts.label2.weightBold.withColor(color),
          );
        case ButtonSize.small:
          return Text(
            title!,
            style: PodiTexts.label2.weightBold.withColor(color),
          );
        case ButtonSize.tiny:
          return Text(
            title!,
            style: PodiTexts.label3.weightBold.withColor(color),
          );
      }
    }

    Widget getChild() {
      List<Widget> orders = [];

      if (controlAffinity == ListTileControlAffinity.leading) {
        orders = [
          if (getIcon() != null) getIcon()!,
          if (getText() != null) getText()!,
        ];
      } else {
        orders = [
          if (getText() != null) getText()!,
          if (getIcon() != null) getIcon()!,
        ];
      }

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: orders.separatedBy(const SizedBox(width: 10)),
      );
    }

    double getRadius() {
      if (size == ButtonSize.tiny) {
        return 4.0;
      }
      return 6.0;
    }

    Widget button() {
      return Container(
        padding: getPadding(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getRadius()),
          border: borderColor != null ? Border.all(color: borderColor) : null,
        ),
        child: getChild(),
      );
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(getRadius()),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(getRadius()),
        hoverColor: hoverColor ?? PodiColors.white.withOpacity(0.25),
        splashColor: splashColor,
        child: button(),
      ),
    );
  }

  static primary({
    String? title,
    IconData? icon,
    Function()? onTap,
    ButtonSize size = ButtonSize.medium,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
    bool enabled = true,
  }) {
    return theme(
      backgroundColor: enabled ? PodiColors.green : PodiColors.green[50]!,
      color: enabled ? PodiColors.white : PodiColors.green[200]!,
      hoverColor: PodiColors.green[300],
      splashColor: PodiColors.green[600],
      title: title,
      icon: icon,
      onTap: enabled ? onTap ?? () {} : null,
      size: size,
      controlAffinity: controlAffinity,
    );
  }

  static secondary({
    String? title,
    IconData? icon,
    Function()? onTap,
    ButtonSize size = ButtonSize.medium,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
    bool enabled = true,
  }) {
    return theme(
      backgroundColor: PodiColors.white,
      color: enabled ? PodiColors.neutrals[800]! : PodiColors.neutrals[200]!,
      borderColor:
          enabled ? PodiColors.neutrals[200] : PodiColors.neutrals[100],
      hoverColor: PodiColors.neutrals[100],
      splashColor: PodiColors.neutrals[200],
      title: title,
      icon: icon,
      onTap: enabled ? onTap ?? () {} : null,
      size: size,
      controlAffinity: controlAffinity,
    );
  }

  static simple({
    String? title,
    IconData? icon,
    Function()? onTap,
    ButtonSize size = ButtonSize.medium,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
    bool enabled = true,
  }) {
    return theme(
      backgroundColor: Colors.transparent,
      color: enabled ? PodiColors.neutrals[800]! : PodiColors.neutrals[200]!,
      hoverColor: PodiColors.neutrals[100],
      title: title,
      icon: icon,
      onTap: enabled ? onTap ?? () {} : null,
      size: size,
      controlAffinity: controlAffinity,
    );
  }
}
