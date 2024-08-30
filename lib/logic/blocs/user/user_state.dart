// ignore_for_file: must_be_immutable

part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class LoadingState extends UserState {}

final class LoadedState extends UserState {
  User user;

  LoadedState(this.user);
}

final class ErrorState extends UserState {
  String message;

  ErrorState(this.message);
}
