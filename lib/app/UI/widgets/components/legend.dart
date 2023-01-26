import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final String text;
  final Color color;

  const LegendItem({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 40, minWidth: 10),
          child: Container(
            height: 15,
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.84),
              color: color,
            ),
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
