import 'package:flutter/material.dart';
import 'package:mobile_dev_graph_app/app/services/degree_to_radian.dart';
import '../../../theme/app_theme.dart';
import '../../ui_helpers/shadows.dart';
import '../../ui_helpers/ngo_affiliation_colors.dart';
import 'pie_chart_painter.dart';
import '../../../services/calculate_angle.dart';
import '../../../services/init_sum_total.dart';
import '../components/legend.dart';

class NGOAffiliationChart extends StatelessWidget {
  /// Format: [{"affliationStatus": "YES", "angle": 100, "color": Color}]
  /// "count" sums up to 360
  final List<Map<String, dynamic>> nameToAngleList = [];

  late final int sumTotal;

  NGOAffiliationChart({
    super.key,

    /// Format: [{'affliationStatus': 'String', 'count': int}]
    required List<Map<String, dynamic>> ngoAffiliationData,
  }) {
    sumTotal = initializeSumTotal(ngoAffiliationData);
    // Populate nameToAngle
    for (Map<String, dynamic> i in ngoAffiliationData) {
      final String tempName =
          i['affliationStatus'] != 'Do you belong to any NGO? '
              ? i['affliationStatus']
              : 'Unknown';
      nameToAngleList.add({
        'affliationStatus': tempName,
        'angle': calculateAngle(quantity: i['count'], total: sumTotal),
        'color': getNGOAffiliationColor(tempName),
      });
    }
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
              'WIDOWS AFFLIATION TO NGO ',
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
                  child: Transform.rotate(
                    angle: degreeToRadian(275),
                    child: CustomPaint(
                      foregroundPainter:
                          PieChartPainter(nameToAngleList: nameToAngleList),
                    ),
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
