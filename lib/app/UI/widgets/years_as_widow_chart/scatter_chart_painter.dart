import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class YearsAsWidowScatterPlotPainter extends CustomPainter {
  /// Format: [{'yearsAsWidow': 'String', 'count': int}]
  final List<Map<String, dynamic>> yearsAsWidowData;

  YearsAsWidowScatterPlotPainter({required this.yearsAsWidowData});

  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> scatterPoints = [];
    final double xSpacing = size.width / (yearsAsWidowData.length - 1);
    print(xSpacing);
    print(yearsAsWidowData.length);
    print(size.width);

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [deepBlue, deepBlue.withOpacity(0.04)],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
