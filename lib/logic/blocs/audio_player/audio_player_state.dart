part of 'audio_player_bloc.dart';

sealed class AudioPlayerState {}

final class InitialAudioPlayerState extends AudioPlayerState {}

final class LoadingAudioPlayerState extends AudioPlayerState {}

final class LoadedAudioPlayerState extends AudioPlayerState {
  final String audioUrl;

  LoadedAudioPlayerState(this.audioUrl);
}

final class ErrorAudioPlayerState extends AudioPlayerState {
  final String message;

  ErrorAudioPlayerState(this.message);
}
