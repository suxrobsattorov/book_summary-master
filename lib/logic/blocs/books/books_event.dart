part of 'books_bloc.dart';

sealed class BooksEvent {}

final class GetBooksEvent extends BooksEvent {}

final class EditBookEvent extends BooksEvent {
  final String id;
  final Book book;

  EditBookEvent(this.id, this.book);
}

final class DeleteBookEvent extends BooksEvent {
  final String id;

  DeleteBookEvent(this.id);
}

final class ToggleBookFavoriteEvent extends BooksEvent {
  final String id;
  final bool isLike;

  ToggleBookFavoriteEvent(
    this.id,
    this.isLike,
  );
}

final class BookRateEvent extends BooksEvent {
  final String id;
  final double rate;

  BookRateEvent(
    this.id,
    this.rate,
  );
}
