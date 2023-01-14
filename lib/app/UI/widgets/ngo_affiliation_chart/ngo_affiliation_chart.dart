import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';
import '../../ui_helpers/shadows.dart';
import 'pie_chart_painter.dart';
import '../../../constants/app_theme.dart';
import '../../../services/calculate_angle.dart';

class NGOAffiliationChart extends StatelessWidget {
  /// Format: [{'affliationStatus': 'String', 'count': int}]
  final List<Map<String, dynamic>> ngoAffiliationData;

  late final int sumTotal;

  /// Format: [{"affliationStatus": "YES", "angle": 100, "color": Color}]
  /// "count" sums up to 360
  final List<Map<String, dynamic>> nameToAngleList = [];

  NGOAffiliationChart({super.key, required this.ngoAffiliationData}) {
    sumTotal = initializeSumTotal(ngoAffiliationData);
    // Populate nameToAngle
    for (Map<String, dynamic> i in ngoAffiliationData) {
      nameToAngleList.add({
        'affliationStatus':
            i['affliationStatus'] != 'Do you belong to any NGO? '
                ? i['affliationStatus']
                : 'Unknown',
        'angle': calculateAngle(quantity: i['count'], total: sumTotal),
        'color': i['affliationStatus'] == "YES"
            ? deepBlue
            : i['affliationStatus'] == "NO"
                ? normalBlue
                : Colors.black,
      });
      // break;
    }
  }
  int initializeSumTotal(data) {
    int total = ngoAffiliationData.fold(
        0, (previousValue, element) => element['count'] + previousValue);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pureWhite,
        borderRadius: BorderRadius.circular(11.69),
        boxShadow: [
          customShadow1(
            dx: 3.51,
            dy: 3.51,
            blurRadius: 17.53,
            opacity: 0.2,
          ),
          customShadow2(
            dx: 1.17,
            dy: 1.17,
            blurRadius: 2.34,
            opacity: 0.25,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Text
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, bottom: 29),
            child: Text(
              'WIDOW\'S AFFLIATION TO NGO ',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: nearBlack,
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 15, bottom: 23),
            child: Row(
              children: [
                // Pie chart
                Container(
                  width: 170,
                  height: 170,
                  margin: const EdgeInsets.only(right: 8),
                  child: CustomPaint(
                    foregroundPainter: PieChartPainter(
                        nameToAngleList: nameToAngleList, sumTotal: sumTotal),
                  ),
                ),

                // Legend
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (Map<String, dynamic> item in nameToAngleList)
                      LegendItem(
                          text: item['affliationStatus'], color: item['color'])
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

class LegendItem extends StatelessWidget {
  final String text;
  final Color color;

  const LegendItem({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 15,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.84),
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 6,
            fontWeight: FontWeight.w400,
            color: Color(0xFF0F0F0F),
          ),
        ),
      ],
    );
  }
}
