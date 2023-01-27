import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import 'triangle_painter.dart';
import '../../ui_helpers/shadows.dart';

class Indicator extends StatelessWidget {
  final double value;
  final bool isBlue;

  const Indicator({super.key, required this.value, this.isBlue = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Rounded rectangle
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              customShadow1(dx: 1.63, dy: 1.63, blurRadius: 8.15, opacity: 0.2),
              customShadow2(dx: 0.54, dy: 0.54, blurRadius: 1.09, opacity: 0.25)
            ],
          ),
          child: Container(
            width: 11.14,
            height: 8.85,
            decoration: BoxDecoration(
              color: isBlue ? deepBlue : commentBoxColor,
              borderRadius: BorderRadius.circular(2.45),
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 4.35,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  color: isBlue ? pureWhite : deepBlue,
                ),
              ),
            ),
          ),
        ),

        // Triangle
        SizedBox(
          width: 4.59,
          height: 4.42,
          child: CustomPaint(
            foregroundPainter:
                TrianglePainter(color: isBlue ? deepBlue : commentBoxColor),
          ),
        ),
      ],
    );
  }
}
