import 'package:flutter/material.dart';

BoxShadow customShadow1({
  required double dx,
  required double dy,
  required double blurRadius,
  required double opacity,
}) {
  return BoxShadow(
    color: const Color(0xFF717171).withOpacity(opacity),
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
    color: const Color(0xFF5690C6).withOpacity(0.2),
    offset: const Offset(2, 2),
    blurRadius: 4,
  );
}
