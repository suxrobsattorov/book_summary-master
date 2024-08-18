import 'package:book_summary/data/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate/rate.dart';

import '../../logic/blocs/all_blocs.dart';

// ignore: must_be_immutable
class SummaryRate extends StatelessWidget {
  Book currentBook;

  SummaryRate({super.key, required this.currentBook});

  @override
  Widget build(BuildContext context) {
    return Rate(
      iconSize: 25,
      color: Colors.yellow.shade700,
      allowHalf: false,
      allowClear: false,
      initialValue: currentBook.rate,
      readOnly: false,
      onChange: (value) {
        context.read<BooksBloc>().add(
              BookRateEvent(currentBook.id, value),
            );
      },
    );
  }
}
