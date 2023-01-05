import 'package:flutter/material.dart';

import '../utils.dart';

class ToastWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String message;
  final Function()? onTap;
  const ToastWidget({
    required this.color,
    required this.title,
    required this.message,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: lighten(color, 0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 8),
            blurRadius: 24,
            color: PodiColors.dark.withOpacity(0.04),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: color, width: 8),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: PodiTexts.body2.size(13).heightCenter.weightBold),
                  const SizedBox(height: 4),
                  Text(message,
                      style:
                          PodiTexts.body2.size(13).heightRegular.weightRegular),
                ],
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.close,
                  color: PodiColors.dark,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
