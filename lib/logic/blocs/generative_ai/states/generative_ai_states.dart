part of '../generative_ai_bloc.dart';

sealed class GenerativeAiStates {}

final class InitialGenerativeAiState extends GenerativeAiStates {}

final class LoadingGenerativeAiState extends GenerativeAiStates {}

final class LoadedGenerativeAiState extends GenerativeAiStates {
  final Book book;

  LoadedGenerativeAiState(this.book);
}

final class ErrorGenerativeAiState extends GenerativeAiStates {
  final String message;

  ErrorGenerativeAiState(this.message);
}
