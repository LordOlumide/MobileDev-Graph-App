import 'package:flutter/material.dart';

class VerticalBar extends StatelessWidget {
  final double ratio;
  final Color barColor;
  final double height;
  final double width;

  const VerticalBar({
    super.key,
    required this.ratio,
    required this.barColor,
    required this.height,
    this.width = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
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
