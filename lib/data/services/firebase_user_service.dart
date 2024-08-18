import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book.dart';
import '../models/user.dart';

class FirebaseUserService {
  final _userCollection = FirebaseFirestore.instance.collection("users");

  Stream<List<User>> getUsers() {
    return _userCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return User.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> addUser(User user) async {
    try {
      await _userCollection.doc(user.id).set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editUser(String id, User user) async {
    try {
      await _userCollection.doc(id).update(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _userCollection.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addBookSummary(String id, Book book) async {
    try {
      await _userCollection.doc(id).set(
        {"history": book},
        SetOptions(merge: true),
      );
    } catch (e) {
      rethrow;
    }
  }
}
