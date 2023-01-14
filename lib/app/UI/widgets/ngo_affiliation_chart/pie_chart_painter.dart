import 'package:flutter/material.dart';
import 'dart:math';
import '../../../services/degree_to_radian.dart';

class PieChartPainter extends CustomPainter {
  /// Format: [{"affliationStatus": "YES", "angle": 100, "color": Color}]
  final List<Map<String, dynamic>> nameToAngleList;

  final int sumTotal;

  const PieChartPainter({
    required this.nameToAngleList,
    required this.sumTotal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    Offset prevArcEndPoint = Offset(center.dx, 0);

    Offset getNextPoint({
      required Offset currentPoint,
      required double angle,
      required double radius,
    }) {
      angle = degreeToRadian(angle);

      print(currentPoint);
      // print(2 * radius * sin(angle / 2) * cos(angle / 2));
      print(2 * radius * sin(angle / 2) * sin(angle / 2));
      double xDisplacement = 2 * radius * sin(angle / 2) * cos(angle / 2);
      double yDisplacement = 2 * radius * sin(angle / 2) * sin(angle / 2);

      double a = currentPoint.dx <= size.width / 2
          ? currentPoint.dx + xDisplacement
          : currentPoint.dx - xDisplacement;
      double b = currentPoint.dy < size.height
          ? currentPoint.dy + yDisplacement
          : currentPoint.dy - yDisplacement;

      // print('a: $a');
      print('b: $b');

      Offset newArcEndPoint = Offset(a, b);
      prevArcEndPoint = newArcEndPoint;
      return newArcEndPoint;
    }

    // double f = 0;
    // print('Test');
    // while (f <= 360) {
    //   print('f = $f');
    //   print(
    //       2 * radius * sin(degreeToRadian(f) / 2) * sin(degreeToRadian(f) / 2));
    //   f += 30;
    // }

    for (Map<String, dynamic> nameToAngle in nameToAngleList) {
      final paint = Paint()
        ..color = nameToAngle['color']
        ..style = PaintingStyle.fill;
      final path = Path();
      path.moveTo(center.dx, center.dy);
      path.lineTo(prevArcEndPoint.dx, prevArcEndPoint.dy);
      if (nameToAngle['angle'] < 180) {
        path.arcToPoint(
          getNextPoint(
              currentPoint: Offset(prevArcEndPoint.dx, prevArcEndPoint.dy),
              angle: nameToAngle['angle'],
              radius: radius),
          radius: Radius.circular(radius),
        );
      } else {
        path.arcToPoint(
          getNextPoint(
              currentPoint: Offset(prevArcEndPoint.dx, prevArcEndPoint.dy),
              angle: 180,
              radius: radius),
          radius: Radius.circular(radius),
        );
        path.close();
        path.lineTo(prevArcEndPoint.dx, prevArcEndPoint.dy);
        path.arcToPoint(
          getNextPoint(
              currentPoint: Offset(prevArcEndPoint.dx, prevArcEndPoint.dy),
              angle: nameToAngle['angle'] - 180,
              radius: radius),
          radius: Radius.circular(radius),
        );
      }
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
