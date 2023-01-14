import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';
import '../../ui_helpers/shadows.dart';
import 'pie_chart_painter.dart';

class NGOAffiliationChart extends StatelessWidget {
  /// Format: {'affliationStatus': 'String', 'count': int}
  final List<Map<String, dynamic>> ngoAffiliationData;

  const NGOAffiliationChart({super.key, required this.ngoAffiliationData});

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

          // Pie chart
          Row(
            children: [
              Container(
                width: 170,
                height: 170,
                margin: const EdgeInsets.only(left: 20, bottom: 23),
                child: CustomPaint(
                  foregroundPainter: PieChartPainter(ngoAffiliationData),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
