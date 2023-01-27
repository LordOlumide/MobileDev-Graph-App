import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class ScatterPlotLabel extends StatelessWidget {
  final String label;

  const ScatterPlotLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 0.94,
            height: 2.82,
            color: pureBlack,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 4.35,
              fontWeight: FontWeight.w400,
              color: pureBlack,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
