import 'package:book_summary/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/book.dart';
import '../../../data/repositories/books_repository.dart';

part 'books_event.dart';

part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepository _booksRepository;
  final AuthRepository _authRepository;

  BooksBloc(
      {required BooksRepository booksRepository,
      required AuthRepository authRepository})
      : _booksRepository = booksRepository,
        _authRepository = authRepository,
        super(InitialBookState()) {
    on<GetBooksEvent>(_getBooks);
    on<EditBookEvent>(_editBook);
    on<DeleteBookEvent>(_deleteBook);
    on<ToggleBookFavoriteEvent>(_toggleBookFavorite);
    on<BookRateEvent>(_bookRate);
  }

  void _getBooks(GetBooksEvent event, Emitter<BooksState> emit) async {
    emit(LoadingBookState());
    try {
      await emit.forEach(
        _booksRepository.getBooks(_authRepository),
        onData: (List<Book> books) {
          return LoadedBookState(books);
        },
      );
    } catch (e) {
      emit(ErrorBookState(e.toString()));
    }
  }

  void _editBook(EditBookEvent event, Emitter<BooksState> emit) async {
    emit(LoadingBookState());
    try {
      await _booksRepository.editBook(event.id, event.book);
    } catch (e) {
      emit(ErrorBookState(e.toString()));
    }
  }

  void _deleteBook(DeleteBookEvent event, Emitter<BooksState> emit) async {
    emit(LoadingBookState());
    try {
      await _booksRepository.deleteBook(event.id);
    } catch (e) {
      emit(ErrorBookState(e.toString()));
    }
  }

  void _toggleBookFavorite(
    ToggleBookFavoriteEvent event,
    Emitter<BooksState> emit,
  ) async {
    emit(LoadingBookState());
    try {
      await _booksRepository.toggleBookFavorite(event.id, event.isLike);
    } catch (e) {
      emit(ErrorBookState(e.toString()));
    }
  }

  void _bookRate(
    BookRateEvent event,
    Emitter<BooksState> emit,
  ) async {
    emit(LoadingBookState());
    try {
      await _booksRepository.bookRate(event.id, event.rate);
    } catch (e) {
      emit(ErrorBookState(e.toString()));
    }
  }
}
