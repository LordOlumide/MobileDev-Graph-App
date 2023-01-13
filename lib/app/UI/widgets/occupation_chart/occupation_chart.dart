import 'package:flutter/material.dart';
import '../section2_container.dart';
import '../../../services/number_rounder.dart';

class OccupationChart extends StatelessWidget {
  /// Format: {'occupation': 'String', 'count': int}
  final List<Map<String, dynamic>> occupationData;

  late final int yAxisMaxLabel;

  OccupationChart({super.key, required this.occupationData}) {
    yAxisMaxLabel = initializeNaxNum();
  }

  int initializeNaxNum() {
    int maxNum = occupationData.fold(
        0,
        (previousValue, element) => element['count'] > previousValue
            ? element['count']
            : previousValue);
    return roundNumUpToNext100(maxNum);
  }

  @override
  Widget build(BuildContext context) {
    return Container2(
      child: Column(
        children: [],
      ),
    );
  }
}
