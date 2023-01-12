import 'package:flutter/material.dart';
import '../../../services/number_rounder.dart';
import '../../ui_helpers/shadows.dart';
import '../../../constants/app_theme.dart';
import 'components/label_bar.dart';
import 'components/bar.dart';

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
        color: pureWhite,
        borderRadius: BorderRadius.circular(5.43),
        boxShadow: [
          customShadow1(
            dx: 1.63,
            dy: 1.63,
            blurRadius: 8.15,
            opacity: 0.2,
          ),
          customShadow2(
            dx: 0.54,
            dy: 0.54,
            blurRadius: 1.09,
            opacity: 0.25,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Text
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 8, bottom: 19),
            child: Text(
              'WIDOWS REGISTERED BY LOCAL GOVERNMENT',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: nearBlack,
              ),
            ),
          ),

          // Table
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name of Local Government
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: registrationData
                      .map((personData) => Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: Text(
                              '${personData['lga']}  -',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 6,
                                fontWeight: FontWeight.w400,
                                color: nearBlack,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(width: 8),

                // Bars
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: Sort in reverse order of name
                    ...registrationData
                        .map((personData) => Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, left: 2, right: 2),
                              child: Bar(
                                ratio: personData['count'] / xAxisMaxLabel,
                                barColor: deepBlue,
                                width:
                                    MediaQuery.of(context).size.width / 2.2268,
                              ),
                            ))
                        .toList(),
                    const SizedBox(height: 8),
                    LabelBar(
                      maxLabel: xAxisMaxLabel,
                      xSpaceAvailable:
                          (MediaQuery.of(context).size.width / 2.2268) + 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
