import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/night_day.dart';
import '../../logic/blocs/books/books_bloc.dart';

class SavedBooksScreen extends StatelessWidget {
  const SavedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
        title: const Text("Xulosalar Tarixi"),
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
                    child: Text("Saqlangan kitoblar mavjud emas"),
                  )
                : ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder: (ctx, index) {
                      final book = state.books[index];
                      return ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.author),
                      );
                    },
                  );
          }

          return const Center(
            child: Text("Saqlangan kitoblar mavjud emas"),
          );
        },
      ),
    );
  }
}
