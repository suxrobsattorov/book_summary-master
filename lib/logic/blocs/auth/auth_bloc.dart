import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../data/models/user.dart' as u;
import '../../../data/repositories/user_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(AuthState()) {
    on<InitialAuthEvent>(_onInitialize);
    on<ToggleLoginFormEvent>(_onToggleLoginForm);
    on<AuthenticateEvent>(_onAuthenticate);
    on<WatchAuthEvent>(_onWatch);
    on<LogoutEvent>(_onLogout);
  }

  _onInitialize(InitialAuthEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      passwordConfirmController: TextEditingController(),
      status: AuthStatus.initial,
    ));
  }

  _onWatch(WatchAuthEvent event, Emitter<AuthState> emit) async {
    await emit.forEach(authRepository.watchAuth(), onData: (user) {
      return state.copyWith(
        user: user,
        status: user == null
            ? AuthStatus.unauthenticated
            : AuthStatus.authenticated,
      );
    });
  }

  _onToggleLoginForm(ToggleLoginFormEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      isLogin: !state.isLogin,
      status: AuthStatus.initial,
      emailController: state.emailController!..clear(),
      passwordController: state.passwordController!..clear(),
      passwordConfirmController: state.passwordConfirmController!..clear(),
    ));
  }

  _onAuthenticate(AuthenticateEvent event, Emitter<AuthState> emit) async {
    if (state.formKey.currentState!.validate()) {
      emit(state.copyWith(status: AuthStatus.loading));
      try {
        if (state.isLogin) {
          await authRepository.login(
            state.emailController!.text,
            state.passwordController!.text,
          );
        } else {
          final user = await authRepository.register(
            state.emailController!.text,
            state.passwordController!.text,
          );

          await userRepository.addUser(
            u.User(
              id: user.uid,
              fullname: "",
              email: user.email!,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
      }
    }
  }

  _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await authRepository.logout();
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }
}
