import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(title), Text(value)]),
    );
  }
}
