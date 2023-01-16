import 'package:flutter/material.dart';
import '../../../services/degree_to_radian.dart';
import 'dart:math';

class TorusShapedPieChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> nameToAngleList;

  final double thickness = 20;

  const TorusShapedPieChartPainter({required this.nameToAngleList});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect rect = Rect.fromCenter(
      center: center,
      width: size.width - thickness,
      height: size.height - thickness,
    );
    double startAngleInRadian = 0 - (pi / 2);

    for (Map<String, dynamic> nameToAngle in nameToAngleList) {
      final double sweepAngleInRadian = degreeToRadian(nameToAngle['angle']);

      final paint = Paint()
        ..color = nameToAngle['color']
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness;
      final path = Path()..addArc(rect, startAngleInRadian, sweepAngleInRadian);

      startAngleInRadian += sweepAngleInRadian;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
