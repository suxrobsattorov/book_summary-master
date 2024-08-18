part of 'translate_bloc.dart';

@immutable
abstract class TranslateEvent {}

final class ConvertTranslateEvent extends TranslateEvent {
  final String language;
  final String text;

  ConvertTranslateEvent(this.text, this.language);
}
