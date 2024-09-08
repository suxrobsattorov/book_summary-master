import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book.dart';
import '../../logic/blocs/all_blocs.dart';

class BookFavorite extends StatelessWidget {
  Book book;

  BookFavorite({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, booksState) {
        Book currentBook = book;

        if (booksState is LoadedBookState) {
          currentBook = booksState.books.firstWhere((b) {
            return b.id == currentBook.id;
          });
        }

        return IconButton(
          onPressed: () {
            context.read<BooksBloc>().add(
                  ToggleBookFavoriteEvent(
                      currentBook.id, !currentBook.isFavorite),
                );
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          icon: Icon(
            currentBook.isFavorite
                ? Icons.favorite
                : Icons.favorite_border_outlined,
          ),
        );
      },
    );
  }
}
