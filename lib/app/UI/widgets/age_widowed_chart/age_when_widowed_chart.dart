import 'package:flutter/material.dart';
import '../components/container_2.dart';
import '../../../services/number_rounder.dart';
import '../../../constants/app_theme.dart';
import '../components/vertical_bar.dart';
import '../components/vertical_label/vertical_label_bar.dart';
import '../../../services/year_sorter.dart';

class AgeWhenWidowedChart extends StatelessWidget {
  /// Format: {'ageWhenWidowed': int, 'count': int}
  final List<Map<String, dynamic>> ageWhenWidowedData;

  const AgeWhenWidowedChart({super.key, required this.ageWhenWidowedData});

  int initializeMaxNum(List<Map<String, dynamic>> displayCopy) {
    int maxNum = displayCopy.fold(
        0,
        (previousValue, element) => element['count'] > previousValue
            ? element['count']
            : previousValue);
    print(roundNumUpToNext10(maxNum));
    return roundNumUpToNext10(maxNum);
  }

  List<Map<String, dynamic>> setDisplayCopy() {
    List<Map<String, dynamic>> tempCopy = [];
    for (Map<String, dynamic> item in ageWhenWidowedData) {
      final String ageString = yearSorter(item['ageWhenWidowed']);
      final int ageCount = item['count'];

      bool matchFound = false;
      for (Map<String, dynamic> stored in tempCopy) {
        if (ageString == stored['ageRange']) {
          stored['count'] += ageCount;
          matchFound = true;
          break;
        }
      }
      if (matchFound == false) {
        tempCopy.add({'ageRange': ageString, 'count': ageCount});
      }
    }
    return tempCopy;
  }

  @override
  Widget build(BuildContext context) {
    /// Format: {'ageRange': String, 'count': int}
    List<Map<String, dynamic>> displayCopy = setDisplayCopy();
    print(displayCopy);
    final int yAxisMaxLabel = initializeMaxNum(displayCopy);

    return ShadowedContainer2(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Text
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16),
            child: Text(
              'WIDOWS AGE AT SPOUSE BEREAVEMENT',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 24),

          Column(
            children: [
              // Series 1 marker
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 13,
                    height: 7,
                    color: deepBlue,
                    margin: const EdgeInsets.only(right: 7, bottom: 1),
                  ),
                  const Text(
                    'Series 1',
                    style: TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0F0F0F),
                    ),
                  ),
                ],
              ),

              // Main Graph
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vertical Axis
                  Column(
                    children: [
                      VerticalLabelBar(
                        maxLabel: yAxisMaxLabel,
                        minLabel: 0,
                        ySpaceAvailable: 140 + 5,
                        noOfLabels: 10,
                      ),
                    ],
                  ),
                  const SizedBox(width: 7),

                  // Bars
                  Container(
                    margin: const EdgeInsets.only(bottom: 24, top: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...displayCopy
                            .map((personData) => _barAndLabel(
                                  personData: personData,
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
        ],
      ),
    );
  }

  Column _barAndLabel({
    required Map<String, dynamic> personData,
    required int yAxisMaxLabel,
  }) {
    return Column(
      children: [
        VerticalBar(
          ratio: personData['count'] / yAxisMaxLabel,
          barColor: deepBlue,
          height: 140,
        ),
        const SizedBox(height: 6),
        Container(width: 1, height: 3, color: pureBlack),
        const SizedBox(height: 3),
        SizedBox(
          width: 22,
          child: Text(
            personData['ageRange'],
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
