import 'package:flutter/material.dart';
import '../../constants/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Container1 extends StatelessWidget {
  final String image;
  final String iconPath;
  final String headerText;
  final int? count;

  const Container1({
    super.key,
    required this.image,
    required this.iconPath,
    required this.headerText,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          alignment: Alignment.bottomRight,
        ),
        boxShadow: [shadow1, shadow2],
      ),
      child: Column(
        children: [
          Row(
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
                  color: normalBlue.withOpacity(0.67),
                ),
              ),
            ],
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
