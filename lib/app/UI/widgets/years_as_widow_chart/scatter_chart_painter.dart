import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../services/init_sum_total.dart';

class YearsAsWidowScatterPlotPainter extends CustomPainter {
  /// Format: [{'yearsAsWidow': 'String', 'count': int}]
  final List<Map<String, dynamic>> yearsAsWidowData;

  late final int maxValue;
  late final int minValue;

  YearsAsWidowScatterPlotPainter({required this.yearsAsWidowData}) {
    maxValue = (yearsAsWidowData.fold(
            0,
            (previousValue, element) => element['count'] > previousValue
                ? element['count']
                : previousValue) +
        15);
    minValue = (yearsAsWidowData.fold(
            maxValue,
            (previousValue, element) => element['count'] < previousValue
                ? element['count']
                : previousValue) +
        15);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> scatterPoints = [];
    final double xSpacing = size.width / (yearsAsWidowData.length - 1);

    double xCoord = 0;
    for (Map<String, dynamic> i in yearsAsWidowData) {
      final Offset point =
          Offset(xCoord, (size.height - (i['count'] / maxValue) * size.height));
      scatterPoints.add(point);
      xCoord += xSpacing;
    }

    final double highestYPoint = scatterPoints.fold(
        0,
        (previousValue, element) =>
            element.dy > previousValue ? element.dy : previousValue);

    // Gradient Layer
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [deepBlue, deepBlue.withOpacity(0.04)],
        stops: [highestYPoint / maxValue, 1],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    for (Offset point in scatterPoints) {
      path.lineTo(point.dx, point.dy);
    }
    path.close();

    canvas.drawPath(path, paint);

    // Border
    final borderPaint = Paint()
      ..color = deepBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.36
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < scatterPoints.length - 1; i++) {
      canvas.drawLine(scatterPoints[i], scatterPoints[i + 1], borderPaint);
    }

    // Circles
    final circleBorderPaint = Paint()
      ..color = deepBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.09;
    final circleInnerPaint = Paint()
      ..color = pureWhite
      ..style = PaintingStyle.fill;
    for (int i = 0; i < scatterPoints.length; i++) {
      canvas.drawCircle(scatterPoints[i], 1, circleInnerPaint);
      canvas.drawCircle(scatterPoints[i], 1.765, circleBorderPaint);
    }

    // Value Indicators
    for (int i = 0; i < scatterPoints.length; i++) {
      Offset boxOrigin =
          Offset(scatterPoints[i].dx, scatterPoints[i].dy - 2.88);

      final bool isMaxOrMin = yearsAsWidowData[i]['count'] == maxValue ||
          yearsAsWidowData[i]['count'] == minValue;

      final commentBoxPaint = Paint()
        ..color = isMaxOrMin ? deepBlue : commentBoxColor
        ..style = PaintingStyle.fill;

      final commentBoxPath = Path();
      // Triangle
      path.moveTo(boxOrigin.dx, boxOrigin.dx);
      path.lineTo(boxOrigin.dx - 1.7, boxOrigin.dy - 2.94);
      path.lineTo(boxOrigin.dx + 1.7, boxOrigin.dy + 2.94);
      path.moveTo(boxOrigin.dx, boxOrigin.dx);
      // RRect
      final RRect rrect = RRect.fromLTRBAndCorners(
        boxOrigin.dx - 5.575,
        boxOrigin.dy - 11.79,
        boxOrigin.dx + 5.575,
        boxOrigin.dy - 2.95,
        topLeft: const Radius.circular(2.45),
        topRight: const Radius.circular(2.45),
        bottomLeft: const Radius.circular(2.45),
        bottomRight: const Radius.circular(2.45),
      );
      path.addRRect(rrect);
      // shadow
      canvas.drawShadow(
          commentBoxPath, shadow1Color.withOpacity(0.2), 2.0, false);
      // text
      final textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: yearsAsWidowData[i]['count'],
          style: TextStyle(
            fontSize: 4.35,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
            color: isMaxOrMin ? pureWhite : deepBlue,
          ),
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, rrect.center);

      canvas.drawPath(commentBoxPath, commentBoxPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
