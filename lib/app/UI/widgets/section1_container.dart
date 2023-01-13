import 'package:flutter/material.dart';
import '../../constants/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ui_helpers/shadows.dart';

class Section1 extends StatelessWidget {
  final String image;
  final String iconPath;
  final String headerText;
  final int? count;
  final Color iconColor;

  const Section1({
    super.key,
    required this.image,
    required this.iconPath,
    required this.headerText,
    required this.count,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pureWhite,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          alignment: Alignment.bottomRight,
        ),
        boxShadow: [
          customShadow1(
            dx: 6,
            dy: 6,
            blurRadius: 30,
            opacity: 0.2,
          ),
          customShadow2(
            dx: 2,
            dy: 2,
            blurRadius: 4,
            opacity: 0.2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headerText,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: nearBlack,
                  ),
                ),
                SizedBox(
                  width: 24,
                  height: 14.5,
                  child: SvgPicture.asset(
                    iconPath,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 42),
          Text(
            count != null ? count.toString() : '---',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
