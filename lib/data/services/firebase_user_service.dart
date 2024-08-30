import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book.dart';
import '../models/user.dart';

class FirebaseUserService {
  final _userCollection = FirebaseFirestore.instance.collection("users");

  Stream<User?> getUser(String userId) {
    return _userCollection.snapshots().map((querySnapshot) {
      User? user;
      querySnapshot.docs.map((doc) {
        if (doc.id == userId) {
          user = User.fromMap(doc.data(), userId);
        }
        return User.fromMap(doc.data(), userId);
      }).toList();
      return user;
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
}
