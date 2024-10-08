import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/night_day.dart';
import '../../core/utils/texts.dart';
import '../../data/models/book.dart';
import '../../logic/blocs/books/books_bloc.dart';
import 'summary_history_screen.dart';

class SavedBooksScreen extends StatelessWidget {
  const SavedBooksScreen({super.key});

  static const routeName = '/saved_history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
        title: Texts.textAppBar('Sevimli kitoblar'),
        centerTitle: true,
      ),
      body: BlocBuilder<BooksBloc, BooksState>(
        builder: (ctx, state) {
          if (state is LoadingBookState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorBookState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is LoadedBookState) {
            List<Book> books = [];
            for (Book b in state.books) {
              if (b.isFavorite) {
                books.add(b);
              }
            }
            return books.isEmpty
                ? const Center(
                    child: Text("Sevimli kitoblar mavjud emas"),
                  )
                : ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (ctx, index) {
                      final book = books[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        color: Colors.deepOrange.shade100,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                SummaryHistoryScreen.routeName,
                                arguments: book);
                          },
                          child: ListTile(
                            title: Text(book.title),
                            subtitle: Text(book.author),
                            trailing: const Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }

          return const Center(
            child: Text("Sevimli kitoblar mavjud emas"),
          );
        },
      ),
    );
  }
}
