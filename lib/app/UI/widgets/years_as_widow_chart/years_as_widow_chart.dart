import 'package:flutter/material.dart';
import '../../ui_helpers/shadows.dart';
import '../../../theme/app_theme.dart';

class YearsSpentAsWidowChart extends StatelessWidget {
  /// Format: [{'yearsAsWidow': 'String', 'count': int}]
  final List<Map<String, dynamic>> yearsAsWidowData;

  final List<Map<String, dynamic>> yearsAsWidowData2 = [];

  YearsSpentAsWidowChart({super.key, required this.yearsAsWidowData}) {
    for (Map<String, dynamic> i in yearsAsWidowData) {
      if (i['yearsAsWidow'] > 20) {
        yearsAsWidowData2[18]['count'] += i['count'];
      } else {
        yearsAsWidowData2.add(i);
      }
    }
    print(yearsAsWidowData2);
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
            padding: const EdgeInsets.only(top: 24, left: 16),
            child: Text(
              'WIDOWS AFFLIATION TO NGO ',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: nearBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
