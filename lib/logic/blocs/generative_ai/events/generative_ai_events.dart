part of '../generative_ai_bloc.dart';

sealed class GenerativeAiEvents {}

final class SummarizeAiEvent extends GenerativeAiEvents {
  final List<Uint8List> files;
  final SummaryLength summaryLength;

  SummarizeAiEvent(this.files, this.summaryLength);
}
