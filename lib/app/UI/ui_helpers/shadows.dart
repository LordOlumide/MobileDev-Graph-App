import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

BoxShadow customShadow1({
  required double dx,
  required double dy,
  required double blurRadius,
  required double opacity,
}) {
  return BoxShadow(
    color: shadow1Color.withOpacity(opacity),
    offset: Offset(dx, dy),
    blurRadius: blurRadius,
  );
}

BoxShadow customShadow2({
  required double dx,
  required double dy,
  required double blurRadius,
  required double opacity,
}) {
  return BoxShadow(
    color: shadow2Color.withOpacity(0.2),
    offset: const Offset(2, 2),
    blurRadius: 4,
  );
}
