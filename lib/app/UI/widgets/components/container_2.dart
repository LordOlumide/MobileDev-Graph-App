import 'package:flutter/material.dart';
import '../../ui_helpers/shadows.dart';
import '../../../theme/app_theme.dart';

class ShadowedContainer2 extends StatelessWidget {
  final Widget child;

  const ShadowedContainer2({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pureWhite,
        borderRadius: BorderRadius.circular(5.43),
        boxShadow: [
          customShadow1(
            dx: 1.63,
            dy: 1.63,
            blurRadius: 8.15,
            opacity: 0.2,
          ),
          customShadow2(
            dx: 0.54,
            dy: 0.54,
            blurRadius: 1.09,
            opacity: 0.25,
          ),
        ],
      ),
      child: child,
    );
  }
}
