part of 'label_bar.dart';

class Label extends StatelessWidget {
  final int label;

  const Label(this.label, {super.key});

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
