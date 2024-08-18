part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class InitialAuthEvent extends AuthEvent {}

final class ToggleLoginFormEvent extends AuthEvent {}

final class AuthenticateEvent extends AuthEvent {}

final class WatchAuthEvent extends AuthEvent {}

final class LogoutEvent extends AuthEvent {}
