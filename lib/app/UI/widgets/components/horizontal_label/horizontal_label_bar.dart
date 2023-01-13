import 'package:flutter/material.dart';

part 'horizontal_label.dart';

class HorizontalLabelBar extends StatelessWidget {
  final int maxLabel;
  final int noOfLabels;
  final double xSpaceAvailable;

  const HorizontalLabelBar({
    super.key,
    required this.maxLabel,
    required this.xSpaceAvailable,
    this.noOfLabels = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: xSpaceAvailable,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i <= maxLabel; i += (maxLabel ~/ noOfLabels))
            HorizontalLabel(i)
        ],
      ),
    );
  }
}
