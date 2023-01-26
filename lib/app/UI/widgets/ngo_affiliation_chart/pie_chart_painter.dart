import 'package:flutter/material.dart';
import 'dart:math';
import '../../../services/degree_to_radian.dart';

class PieChartPainter extends CustomPainter {
  /// Format: [{"affliationStatus": "YES", "angle": 100, "color": Color}]
  final List<Map<String, dynamic>> nameToAngleList;

  const PieChartPainter({
    required this.nameToAngleList,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    double totalAngleInDegrees = 0;

    Offset startingPoint = Offset(size.width / 2, 0);
    Offset currentPoint = Offset(startingPoint.dx, startingPoint.dy);

    void refreshCurrentPoint() {
      final double angleInRadian = degreeToRadian(totalAngleInDegrees);

      double xDisplacement =
          2 * radius * sin(angleInRadian / 2) * cos(angleInRadian / 2);
      double yDisplacement =
          2 * radius * sin(angleInRadian / 2) * sin(angleInRadian / 2);

      double a = startingPoint.dx + xDisplacement;
      double b = startingPoint.dy + yDisplacement;

      currentPoint = Offset(a, b);
    }

    for (Map<String, dynamic> nameToAngle in nameToAngleList) {
      final paint = Paint()
        ..color = nameToAngle['color']
        ..style = PaintingStyle.fill;

      final path = Path();
      path.moveTo(center.dx, center.dy);
      path.lineTo(currentPoint.dx, currentPoint.dy);

      if (nameToAngle['angle'] <= 180) {
        totalAngleInDegrees += nameToAngle['angle'];
        refreshCurrentPoint();
        path.arcToPoint(currentPoint, radius: Radius.circular(radius));
      } else {
        totalAngleInDegrees += 180;
        refreshCurrentPoint();
        path.arcToPoint(currentPoint, radius: Radius.circular(radius));
        totalAngleInDegrees += nameToAngle['angle'] - 180;
        refreshCurrentPoint();
        path.arcToPoint(currentPoint, radius: Radius.circular(radius));
      }
      path.lineTo(center.dx, center.dy);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
