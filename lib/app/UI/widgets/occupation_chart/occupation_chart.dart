import 'package:flutter/material.dart';
import '../components/container_2.dart';
import '../../../services/number_rounder.dart';
import '../../../theme/app_theme.dart';
import '../components/vertical_bar.dart';
import '../components/vertical_label/vertical_label_bar.dart';
import '../../../services/format_occupation.dart';

class OccupationChart extends StatelessWidget {
  /// Format: {'occupation': 'String', 'count': int}
  final List<Map<String, dynamic>> occupationData;

  late final int yAxisMaxLabel;
  final int minIndex = 1500;

  OccupationChart({super.key, required this.occupationData}) {
    yAxisMaxLabel = initializeMaxNum();
  }

  int initializeMaxNum() {
    int maxNum = occupationData.fold(
        0,
        (previousValue, element) => element['count'] > previousValue
            ? element['count']
            : previousValue);
    return roundNumUpToNext100(maxNum);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayCopy = [];
    for (Map<String, dynamic> item in occupationData) {
      if (item['count'] >= minIndex) {
        displayCopy.add(item);
      }
    }

    return ShadowedContainer2(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Text
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, bottom: 20),
            child: Text(
              'WIDOWS TYPE OF OCCUPATION',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: nearBlack,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vertical Axis
              Column(
                children: [
                  VerticalLabelBar(
                    maxLabel: yAxisMaxLabel,
                    minLabel: minIndex,
                    ySpaceAvailable: 140 + 5,
                    noOfLabels: 10,
                  ),
                ],
              ),

              // Bars
              Container(
                margin: const EdgeInsets.only(
                  bottom: 24,
                  top: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...displayCopy
                        .map((personData) => _barAndLabel(
                              personData: personData,
                              minIndex: minIndex,
                              yAxisMaxLabel: yAxisMaxLabel,
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _barAndLabel({
    required Map<String, dynamic> personData,
    required int minIndex,
    required int yAxisMaxLabel,
  }) {
    return Column(
      children: [
        // Bar
        VerticalBar(
          ratio: (personData['count'] - minIndex) / (yAxisMaxLabel - minIndex),
          barColor: normalBlue,
          height: 140,
        ),
        const SizedBox(height: 7),
        Container(width: 1, height: 3, color: pureBlack),
        const SizedBox(height: 2),

        // Occupation names
        SizedBox(
          width: 35,
          child: Text(
            formatOccupation(personData['occupation']),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 6,
              fontWeight: FontWeight.w400,
              color: nearBlack,
            ),
          ),
        ),
      ],
    );
  }
}
