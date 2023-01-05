import 'package:flutter/material.dart';

import '../utils.dart';

class GreenButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final double height, width, radius;
  final EdgeInsets margin;
  final bool active, busy;
  final TextStyle? style;
  const GreenButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.height = 48,
      this.radius = 12,
      this.active = true,
      this.busy = false,
      this.style,
      this.width = double.infinity,
      this.margin = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        style: BasicButtonStyle(
          elevation: 0,
          backgroundColor: active ? PodiColors.green : PodiColors.green.withOpacity(0.48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: active
            ? busy
                ? () {}
                : onTap
            : null,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          child: busy
              ? SizedBox(
                  height: height - 24,
                  width: height - 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 3,
                  ),
                )
              : Center(
                  child: FittedBox(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: style ??
                          PodiTexts.button1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
