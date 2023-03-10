part of 'horizontal_label_bar.dart';

class HorizontalLabel extends StatelessWidget {
  final int label;

  const HorizontalLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 1,
          height: 3,
          color: Colors.black,
        ),
        Text(
          '$label',
          style: const TextStyle(
            fontSize: 6,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
