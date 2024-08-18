import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/audio_repository.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc({
    required this.audioRepository,
  }) : super(InitialAudioPlayerState()) {
    on<DownloadAudio>(_download);
  }

  final AudioRepository audioRepository;

  void _download(DownloadAudio event, emit) async {
    emit(LoadingAudioPlayerState());

    try {
      final audioUrl = await audioRepository.downloadAudio(event.summary);
      emit(LoadedAudioPlayerState(audioUrl));
    } catch (e) {
      emit(ErrorAudioPlayerState(e.toString()));
    }
  }
}
