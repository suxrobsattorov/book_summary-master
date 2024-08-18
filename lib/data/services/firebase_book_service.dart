import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book.dart';

class FirebaseBookService {
  final _bookCollection = FirebaseFirestore.instance.collection("books");

  Stream<List<Book>> getBooks() {
    // birinchi return'da collection ichiga kiryapmiz (table)
    return _bookCollection.snapshots().map((querySnapshot) {
      // ikkinchi return'da collection ichidagi hujjatlarga kiryapmiz (rows)
      return querySnapshot.docs.map((doc) {
        // uchinchi return'da har bitta hujjatni (row)
        // Book obyektiga aylantiryapmiz
        final map = doc.data();
        map['id'] = doc.id;
        return Book.fromMap(map);
      }).toList();
    });
  }

  Future<String> addBook(Book book) async {
    try {
      final bookDoc = await _bookCollection.add(book.toMap());
      return bookDoc.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editBook(String id, Book book) async {
    try {
      await _bookCollection.doc(id).update(book.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      await _bookCollection.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleBookFavorite(String id, bool isLike) async {
    try {
      await _bookCollection.doc(id).update({
        "isFavorite": isLike,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> bookRate(String id, double rate) async {
    try {
      await _bookCollection.doc(id).update({
        "rate": rate,
      });
    } catch (e) {
      rethrow;
    }
  }
}
