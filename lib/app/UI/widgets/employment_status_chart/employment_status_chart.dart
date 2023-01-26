import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../ui_helpers/shadows.dart';
import '../../ui_helpers/employment_status_colors.dart';
import '../../../services/calculate_angle.dart';
import 'torus_chart.dart';
import '../components/legend.dart';

class EmploymentStatusChart extends StatelessWidget {
  /// Format: [{"employmentStatus": "YES", "angle": 100, "color": Color}]
  /// "count" sums up to 360
  final List<Map<String, dynamic>> nameToAngleList = [];

  late final int sumTotal;

  EmploymentStatusChart({
    super.key,

    /// Format: [{'employmentStatus': 'String', 'count': int}]
    required List<Map<String, dynamic>> employmentStatusData,
  }) {
    sumTotal = initializeSumTotal(employmentStatusData);
    // Populate nameToAngle
    for (Map<String, dynamic> i in employmentStatusData) {
      String tempName = i['employmentStatus'] != 'Employment Status'
          ? i['employmentStatus']
          : 'Unknown';
      nameToAngleList.add({
        'employmentStatus': tempName,
        'angle': calculateAngle(quantity: i['count'], total: sumTotal),
        'color': getEmploymentStatusColor(tempName),
      });
    }
    nameToAngleList
        .sort((a, b) => a['employmentStatus'].compareTo(b['employmentStatus']));
  }
  int initializeSumTotal(data) {
    int total = data.fold(
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
            dx: 3.16,
            dy: 3.16,
            blurRadius: 15.82,
            opacity: 0.2,
          ),
          customShadow2(
            dx: 1.05,
            dy: 1.05,
            blurRadius: 2.11,
            opacity: 0.25,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Torus chart
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CustomPaint(
                    foregroundPainter: TorusShapedPieChartPainter(
                        nameToAngleList: nameToAngleList),
                  ),
                ),
                const SizedBox(
                  width: 113,
                  child: Text(
                    'WIDOWS EMPLOYMENT STATUS',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            // Legend
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (Map<String, dynamic> item in nameToAngleList)
                  LegendItem(
                      text: item['employmentStatus'], color: item['color'])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
