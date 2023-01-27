import 'package:flutter/material.dart';
import '../../ui_helpers/shadows.dart';
import '../../../theme/app_theme.dart';
import 'scatter_chart_painter.dart';
import 'label.dart';

class YearsSpentAsWidowChart extends StatelessWidget {
  /// Format: [{'yearsAsWidow': 'String', 'count': int}]
  final List<Map<String, dynamic>> yearsAsWidowData = [];

  YearsSpentAsWidowChart({super.key, required yearsAsWidowDataTemp}) {
    for (Map<String, dynamic> i in yearsAsWidowDataTemp) {
      if (i['yearsAsWidow'] > 20) {
        yearsAsWidowData[18]['count'] += i['count'];
      } else {
        yearsAsWidowData.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double chartWidth = MediaQuery.of(context).size.width - 120;

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header Text
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 16),
              child: Text(
                'YEARS SPENT AS A WIDOW',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: nearBlack,
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Chart
          SizedBox(
            width: chartWidth,
            height: 95,
            child: CustomPaint(
              foregroundPainter: YearsAsWidowScatterPlotPainter(
                yearsAsWidowData: yearsAsWidowData,
              ),
            ),
          ),
          const SizedBox(height: 3.23),

          SizedBox(
            width: chartWidth + 8.5,
            child: Padding(
              padding: const EdgeInsets.only(right: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < yearsAsWidowData.length; i++)
                    ScatterPlotLabel(
                        label: yearsAsWidowData[i]['yearsAsWidow'] != 20
                            ? yearsAsWidowData[i]['yearsAsWidow'].toString()
                            : '20+'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
