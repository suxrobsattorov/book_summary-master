import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/book.dart';
import '../../logic/blocs/all_blocs.dart';

class BookInfoDialog extends StatelessWidget {

  const BookInfoDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenerativeAiBloc, GenerativeAiStates>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            if (state is LoadedGenerativeAiState) {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: Text(state.book.title),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Author name: ${state.book.author}"),
                        Text(
                          "Published date: ${DateFormat("d MMMM, y").format(state.book.publishedDate)}",
                        ),
                        const Text("Book facts:"),
                        ...(List.generate(state.book.facts.length, (index) {
                          return Text("${index + 1}. ${state.book.facts[index]}");
                        }).toList())
                      ],
                    ),
                  );
                },
              );
            }
          },
          icon: const Icon(Icons.info),
        );
      },
    );
  }
}
