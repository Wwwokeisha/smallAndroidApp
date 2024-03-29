import 'package:flutter/material.dart';

class ModifyText extends StatelessWidget {
  const ModifyText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontFamily: 'Oswald',
        ));
  }
}
