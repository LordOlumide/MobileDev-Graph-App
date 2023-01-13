import 'package:flutter/material.dart';

part 'vertical_label.dart';

class VerticalLabelBar extends StatelessWidget {
  final int maxLabel;
  final int minLabel;
  final int noOfLabels;
  final double ySpaceAvailable;

  const VerticalLabelBar({
    super.key,
    required this.maxLabel,
    required this.minLabel,
    required this.ySpaceAvailable,
    this.noOfLabels = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ySpaceAvailable,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = maxLabel;
              i >= minLabel;
              i -= ((maxLabel - minLabel) ~/ noOfLabels))
            VerticalLabel(i)
        ],
      ),
    );
  }
}
