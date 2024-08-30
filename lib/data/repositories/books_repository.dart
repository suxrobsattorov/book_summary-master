import 'package:book_summary/data/repositories/auth_repository.dart';

import '../models/book.dart';
import '../services/firebase_book_service.dart';

class BooksRepository {
  final FirebaseBookService _firebaseBookService;

  BooksRepository({required FirebaseBookService firebaseBookService})
      : _firebaseBookService = firebaseBookService;

  Stream<List<Book>> getBooks(AuthRepository authRepository) {
    return _firebaseBookService.getBooks(authRepository);
  }

  Future<String> addBook(Book book) async {
    return await _firebaseBookService.addBook(book);
  }

  Future<void> editBook(String id, Book book) async {
    await _firebaseBookService.editBook(id, book);
  }

  Future<void> deleteBook(String id) async {
    await _firebaseBookService.deleteBook(id);
  }

  Future<void> toggleBookFavorite(String id, bool isLike) async {
    await _firebaseBookService.toggleBookFavorite(id, isLike);
  }

  Future<void> bookRate(String id, double rate) async {
    await _firebaseBookService.bookRate(id, rate);
  }
}
