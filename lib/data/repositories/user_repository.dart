import 'package:book_summary/data/models/book.dart';

import '../models/user.dart';
import '../services/firebase_user_service.dart';

class UserRepository {
  final FirebaseUserService firebaseUserService;

  UserRepository({required this.firebaseUserService});

  Stream<User?> getUser(String userId) {
    return firebaseUserService.getUser(userId);
  }

  Future<void> addUser(User user) async {
    await firebaseUserService.addUser(user);
  }

  Future<void> editUser(String id, User user) async {
    await firebaseUserService.editUser(id, user);
  }

  Future<void> deleteUser(String id) async {
    await firebaseUserService.deleteUser(id);
  }
}
