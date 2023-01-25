import 'package:flutter/material.dart';
import '../../../services/number_rounder.dart';
import '../../../theme/app_theme.dart';
import '../components/container_2.dart';
import '../components/horizontal_label/horizontal_label_bar.dart';
import '../components/horizontal_bar.dart';
import '../../../services/north_east_formatter.dart';

class LGAChart extends StatelessWidget {
  /// Format: [{'lga': 'String', 'count': int}]
  late final List<Map<String, dynamic>> lgaRegistrationData;
  final List<Map<String, dynamic>> lgaRegistrationDataTemp;

  late final int xAxisMaxLabel;

  LGAChart({
    super.key,
    required this.lgaRegistrationDataTemp,
  }) {
    // To sort in reverse alphabetical order of "lga"
    lgaRegistrationDataTemp.sort((a, b) => a['lga'].compareTo(b['lga']));
    lgaRegistrationData = lgaRegistrationDataTemp.reversed.toList();
    // To save memory?
    lgaRegistrationDataTemp.clear();
    xAxisMaxLabel = initializeMaxNum();
  }

  int initializeMaxNum() {
    int maxNum = lgaRegistrationData.fold(
        0,
        (previousValue, element) => element['count'] > previousValue
            ? element['count']
            : previousValue);
    return roundNumUpToNext100(maxNum);
  }

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer2(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Text
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, bottom: 19),
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
                  children: lgaRegistrationData
                      .map((personData) => Padding(
                            padding: const EdgeInsets.only(bottom: 7.1),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  formatLocation(personData['lga']),
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 6,
                                    fontWeight: FontWeight.w400,
                                    color: nearBlack,
                                  ),
                                ),
                                Container(
                                  width: 2.71,
                                  height: 1,
                                  color: nearBlack,
                                  margin: const EdgeInsets.only(left: 2.3),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(width: 8),

                // Bars and XAxis grading
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TODO: Sort in reverse order of name
                    ...lgaRegistrationData
                        .map((personData) => Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5, right: 3),
                              child: HorizontalBar(
                                ratio: personData['count'] / xAxisMaxLabel,
                                barColor: deepBlue,
                                width:
                                    MediaQuery.of(context).size.width / 2.2268,
                              ),
                            ))
                        .toList(),
                    const SizedBox(height: 8),
                    HorizontalLabelBar(
                      maxLabel: xAxisMaxLabel,
                      xSpaceAvailable:
                          (MediaQuery.of(context).size.width / 2.2268) + 9,
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
