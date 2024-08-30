part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState {
  final formKey = GlobalKey<FormState>();
  bool isLogin;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? passwordConfirmController;
  AuthStatus? status;
  String? error;
  User? user;

  AuthState({
    this.isLogin = true,
    this.emailController,
    this.passwordController,
    this.passwordConfirmController,
    this.status,
    this.error,
    this.user,
  });

  AuthState copyWith({
    bool? isLogin,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? passwordConfirmController,
    AuthStatus? status,
    String? error,
    User? user,
  }) {
    return AuthState(
      isLogin: isLogin ?? this.isLogin,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      passwordConfirmController:
          passwordConfirmController ?? this.passwordConfirmController,
      status: status ?? this.status,
      error: error,
      user: user,
    );
  }
}


