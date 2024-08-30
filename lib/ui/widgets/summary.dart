import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../logic/blocs/all_blocs.dart';

// ignore: must_be_immutable
class Summary extends StatelessWidget {
  String bookSummaryEn;

  Summary({super.key, required this.bookSummaryEn});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslateBloc, TranslateState>(
      builder: (context, state) {
        if (state is LoadingTranslate) {
          return Expanded(
            child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.green.shade300,
                size: 70,
              ),
            ),
          );
        }
        if (state is ErrorTranslate) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is LoadedTranslate) {
          return Expanded(child: Markdown(data: state.text));
        }
        return Expanded(child: Markdown(data: bookSummaryEn));
      },
    );
  }
}
