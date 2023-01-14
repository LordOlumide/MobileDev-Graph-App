import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';
import '../../ui_helpers/shadows.dart';

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
              SizedBox(
                width: 170,
                height: 170,
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

class PieChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> affiliationData;

  late final int sumTotal;

  /// Format: [{"Yes": 100}, {"No": 200}, {"Unknown": 60}] // sums up to 360
  late final List<Map<String, double>> nameToAngle = [];

  PieChartPainter(this.affiliationData) {
    sumTotal = initializeSumTotal(affiliationData);
    for (Map<String, dynamic> i in affiliationData) {
      print(i);
    }
  }

  int initializeSumTotal(data) {
    int total = affiliationData.fold(
        0, (previousValue, element) => element['count'] + previousValue);
    print(total);
    return total;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final bottomPaint = Paint()
      ..color = deepBlue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, size.width / 2, bottomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
