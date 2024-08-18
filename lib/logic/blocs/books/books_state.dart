part of 'books_bloc.dart';

sealed class BooksState {}

final class InitialBookState extends BooksState {}

final class LoadingBookState extends BooksState {}

final class LoadedBookState extends BooksState {
  List<Book> books;

  LoadedBookState(this.books);
}

final class ErrorBookState extends BooksState {
  String message;

  ErrorBookState(this.message);
}
