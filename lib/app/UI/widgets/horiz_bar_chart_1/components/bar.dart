import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final double ratio;
  final Color barColor;
  final double height;
  final double width;

  const Bar({
    super.key,
    required this.ratio,
    required this.barColor,
    required this.width,
    this.height = 9.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          color: barColor.withOpacity(0.03),
          width: width,
          height: height,
        ),
        Container(
          color: barColor,
          width: width * ratio,
          height: height,
        ),
      ],
    );
  }
}
