import 'package:flutter/material.dart';

import '../../core/utils/texts.dart';

// ignore: must_be_immutable
class ListButtonContainer extends StatelessWidget {
  String text;

  ListButtonContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Color(0xFF02CCAA),
            style: BorderStyle.solid,
            width: 0.5,
          ),
        ),
      ),
      child: Texts.text16(text),
    );
  }
}
