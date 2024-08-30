import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/book.dart';
import '../../logic/blocs/all_blocs.dart';

class BookHistoryInfoDialog extends StatelessWidget {
  Book book;

  BookHistoryInfoDialog({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(book.title),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Author name: ${book.author}"),
                  Text(
                    "Published date: ${DateFormat("d MMMM, y").format(book.publishedDate)}",
                  ),
                  const Text("Book facts:"),
                  ...(List.generate(book.facts.length, (index) {
                    return Text(
                        "${index + 1}. ${book.facts[index]}");
                  }).toList())
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.info),
    );
  }
}
