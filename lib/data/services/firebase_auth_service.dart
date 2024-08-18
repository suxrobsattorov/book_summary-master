import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<User> login(String email, String password) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return response.user!;
    } on FirebaseAuthException catch (e) {
      throw (e.message.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<User> register(String email, String password) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return response.user!;
    } on FirebaseAuthException catch (e) {
      throw (e.message.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Stream<User?> watchAuth() {
    return _auth.authStateChanges();
  }

  User? get currentUser {
    return _auth.currentUser;
  }
}
