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
    // final List<Map<String, dynamic>> testList = [
    //   {"affliationStatus": "YES", "angle": 160.0, "color": Colors.green},
    //   {"affliationStatus": "NO", "angle": 100.0, "color": Colors.blue},
    //   {"affliationStatus": "Unknown", "angle": 100.0, "color": Colors.pink},
    // ];
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    final Rect rect =
        Rect.fromCenter(center: center, width: size.width, height: size.height);

    Offset arcStartPoint = Offset(size.width, size.height / 2);
    double startAngleInRadian = pi + degreeToRadian(6);
    double angleSweptInDegrees = 0;

    Offset getNextStartPoint({
      required double totalAngleInDegrees,
    }) {
      final double angleInRadian = totalAngleInDegrees;

      double xDisplacement =
          2 * radius * sin(angleInRadian / 2) * cos(angleInRadian / 2);
      double yDisplacement =
          2 * radius * sin(angleInRadian / 2) * sin(angleInRadian / 2);

      double a = totalAngleInDegrees > 180
          ? arcStartPoint.dx - xDisplacement
          : arcStartPoint.dx - xDisplacement;
      double b = arcStartPoint.dy + yDisplacement;

      return Offset(a, b);
    }

    for (Map<String, dynamic> nameToAngle in nameToAngleList) {
      final double sweepAngleInRadian = degreeToRadian(nameToAngle['angle']);

      // TODO: Change the implementation to actually draw sectors.
      final paint = Paint()
        ..color = nameToAngle['color']
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width;
      final path = Path();
      // path.moveTo(center.dx, center.dy);
      // path.lineTo(arcStartPoint.dx, arcStartPoint.dy);
      path.addArc(rect, startAngleInRadian, sweepAngleInRadian);
      // path.lineTo(center.dx, center.dy);

      // arcStartPoint = getNextStartPoint(
      //     currentPoint: arcStartPoint,
      //     angleInRadian: sweepAngleInRadian,
      //     radius: radius);
      // startAngleInRadian += sweepAngleInRadian;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
