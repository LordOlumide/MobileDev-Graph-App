import 'package:flutter/material.dart';
import 'dart:math';
import '../../../constants/app_theme.dart';
import '../../../services/calculate_angle.dart';
import '../../../services/degree_to_radian.dart';

class PieChartPainter extends CustomPainter {
  /// Format: [{'affliationStatus': 'String', 'count': int}]
  final List<Map<String, dynamic>> affiliationData;

  late final int sumTotal;

  /// Format: [{"affliationStatus": "YES", "angle": 100, "color": Color}]
  /// "count" sums up to 360
  final List<Map<String, dynamic>> nameToAngleList = [];

  PieChartPainter(this.affiliationData) {
    sumTotal = initializeSumTotal(affiliationData);
    // Populate nameToAngle
    for (Map<String, dynamic> i in affiliationData) {
      nameToAngleList.add({
        'affliationStatus':
            i['affliationStatus'] != 'Do you belong to any NGO? '
                ? i['affliationStatus']
                : 'Unknown',
        'angle': calculateAngle(quantity: i['count'], total: sumTotal),
        'color': i['affliationStatus'] == "YES"
            ? deepBlue
            : i['affliationStatus'] == "NO"
                ? normalBlue
                : Colors.black,
      });
      // break;
    }
  }

  int initializeSumTotal(data) {
    int total = affiliationData.fold(
        0, (previousValue, element) => element['count'] + previousValue);
    return total;
  }

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
