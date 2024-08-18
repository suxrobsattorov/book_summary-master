part of 'audio_player_bloc.dart';

sealed class AudioPlayerEvent {}

final class DownloadAudio extends AudioPlayerEvent {
  final String summary;

  DownloadAudio(this.summary);
}
