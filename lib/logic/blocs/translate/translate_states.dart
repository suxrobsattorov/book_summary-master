part of 'translate_bloc.dart';

@immutable
abstract class TranslateState {}

class InitialTranslate extends TranslateState {}

class LoadingTranslate extends TranslateState {}

class LoadedTranslate extends TranslateState {
  final String text;

  LoadedTranslate(this.text);
}

class ErrorTranslate extends TranslateState {
  final String message;

  ErrorTranslate(this.message);
}
