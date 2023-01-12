import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../services/number_rounder.dart';
import '../../ui_helpers/shadows.dart';

class HorizontalBarChartSection1 extends StatelessWidget {
  /// Format: {'lga': 'String', 'count': int}
  final List<Map<String, dynamic>> registrationData;
  final Color barActiveColor;

  // initialized vars
  late final int xAxisMaxLabel;

  HorizontalBarChartSection1({
    super.key,
    required this.registrationData,
    required this.barActiveColor,
  }) {
    xAxisMaxLabel = initializeNaxNum();
  }

  int initializeNaxNum() {
    int maxNum = registrationData.fold(
        0,
        (previousValue, element) => element['count'] > previousValue
            ? element['count']
            : previousValue);
    return roundNumUpToNext100(maxNum);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.43),
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
