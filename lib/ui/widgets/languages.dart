import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/all_blocs.dart';

// ignore: must_be_immutable
class Languages extends StatelessWidget {
  String bookSummary;

  Languages({super.key, required this.bookSummary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            context
                .read<TranslateBloc>()
                .add(ConvertTranslateEvent(bookSummary, 'en'));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/images/en.png',
              fit: BoxFit.cover,
              width: 40,
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            context
                .read<TranslateBloc>()
                .add(ConvertTranslateEvent(bookSummary, 'uz'));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/images/uz.png',
              fit: BoxFit.cover,
              width: 40,
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            context
                .read<TranslateBloc>()
                .add(ConvertTranslateEvent(bookSummary, 'ru'));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/images/ru.png',
              fit: BoxFit.cover,
              width: 40,
            ),
          ),
        ),
      ],
    );
  }
}
