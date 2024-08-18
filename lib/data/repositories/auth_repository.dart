import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService firebaseAuthService;

  AuthRepository({required this.firebaseAuthService});

  Future<User> login(String email, String password) async {
    return await firebaseAuthService.login(email, password);
  }

  Future<User> register(String email, String password) async {
    return await firebaseAuthService.register(email, password);
  }

  Future<void> logout() async {
    await firebaseAuthService.logout();
  }

  Stream<User?> watchAuth() {
    return firebaseAuthService.watchAuth();
  }

  User? get currentUser {
    return firebaseAuthService.currentUser;
  }
}
