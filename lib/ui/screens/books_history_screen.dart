import 'package:book_summary/ui/screens/summary_history_screen.dart';
import 'package:book_summary/ui/screens/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/night_day.dart';
import '../../core/utils/texts.dart';
import '../../logic/blocs/books/books_bloc.dart';

class BooksHistoryScreen extends StatelessWidget {
  const BooksHistoryScreen({super.key});

  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
        title: Texts.textAppBar('Xulosalar Tarixi'),
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
            return state.books.isEmpty
                ? const Center(
                    child: Text("Kitoblar mavjud emas"),
                  )
                : ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder: (ctx, index) {
                      final book = state.books[index];
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
                            leading: const Icon(
                              Icons.history_edu,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }

          return const Center(
            child: Text("Kitoblar mavjud emas"),
          );
        },
      ),
    );
  }
}
