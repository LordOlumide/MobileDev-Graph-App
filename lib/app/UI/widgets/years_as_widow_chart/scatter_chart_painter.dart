import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class YearsAsWidowScatterPlotPainter extends CustomPainter {
  /// Format: [{'yearsAsWidow': 'String', 'count': int}]
  final List<Map<String, dynamic>> yearsAsWidowData;

  late final int maxValue;
  late final int minValue;

  YearsAsWidowScatterPlotPainter({required this.yearsAsWidowData}) {
    maxValue = yearsAsWidowData.fold(
        0,
        (previousValue, element) => element['count'] > previousValue
            ? element['count']
            : previousValue);
    minValue = yearsAsWidowData.fold(
        maxValue,
        (previousValue, element) => element['count'] < previousValue
            ? element['count']
            : previousValue);
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

    // Gradient Layer
    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [deepBlue, deepBlue.withOpacity(0.04)],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    for (Offset point in scatterPoints) {
      path.lineTo(point.dx, point.dy);
    }
    path.close();

    canvas.drawPath(path, paint);

    // Border
    final Paint borderPaint = Paint()
      ..color = deepBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.36
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < scatterPoints.length - 1; i++) {
      canvas.drawLine(scatterPoints[i], scatterPoints[i + 1], borderPaint);
    }

    // Circles
    final Paint circleBorderPaint = Paint()
      ..color = deepBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.09;
    final Paint circleInnerPaint = Paint()
      ..color = pureWhite
      ..style = PaintingStyle.fill;
    for (int i = 0; i < scatterPoints.length; i++) {
      canvas.drawCircle(scatterPoints[i], 1, circleInnerPaint);
      canvas.drawCircle(scatterPoints[i], 1.765, circleBorderPaint);
    }

    // Value Indicators
    for (int i = 0; i < scatterPoints.length; i++) {
      Offset boxOrigin = Offset(scatterPoints[i].dx, scatterPoints[i].dy - 4.7);

      final bool isMaxOrMin = yearsAsWidowData[i]['count'] == maxValue ||
          yearsAsWidowData[i]['count'] == minValue;

      final Paint commentBoxPaint = Paint()
        ..color = isMaxOrMin ? deepBlue : pureWhite
        ..style = PaintingStyle.fill;

      final Path commentBoxPath = Path();
      // Triangle
      commentBoxPath.moveTo(boxOrigin.dx, boxOrigin.dy);
      commentBoxPath.lineTo(boxOrigin.dx - 2, boxOrigin.dy - 2.95);
      commentBoxPath.lineTo(boxOrigin.dx + 2, boxOrigin.dy - 2.95);
      commentBoxPath.close();
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
      commentBoxPath.addRRect(rrect);
      // // shadow
      canvas.drawShadow(
          commentBoxPath, shadow1Color.withOpacity(0.3), 1.0, false);
      canvas.drawPath(commentBoxPath, commentBoxPaint);

      // text
      final textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        text: TextSpan(
          text: yearsAsWidowData[i]['count'].toString(),
          style: TextStyle(
            fontSize: 4.35,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
            color: isMaxOrMin ? pureWhite : deepBlue,
          ),
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(rrect.center.dx - (textPainter.width / 2),
              rrect.center.dy - (textPainter.height / 2)));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
