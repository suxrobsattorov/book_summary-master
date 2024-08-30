// ignore_for_file: must_be_immutable

part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class GetUserEvent extends UserEvent{}

final class UserEditEvent extends UserEvent {
  String name;
  String surname;

  UserEditEvent(this.name, this.surname);
}
