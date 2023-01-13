part of 'vertical_label_bar.dart';

class VerticalLabel extends StatelessWidget {
  final int label;

  const VerticalLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label',
          style: const TextStyle(
            fontSize: 6,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 2.5),
        Container(
          width: 3,
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
