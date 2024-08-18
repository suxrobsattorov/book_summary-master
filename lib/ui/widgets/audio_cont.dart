import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../logic/blocs/audio_player/audio_player_bloc.dart';

class AudioCont extends StatelessWidget {
  AudioCont({super.key});
  final player = AudioPlayer();

  void play(String url) async {
    player.setVolume(2);
    await player.setUrl(url);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () async {
            await player.seek(
              Duration(seconds: player.duration!.inSeconds - 3),
            );
          },
          icon: const Icon(Icons.restore_sharp),
        ),
        BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, audioState) {
            print(audioState);
            return IconButton(
              onPressed: () {
                if (audioState is LoadedAudioPlayerState) {
                  play(audioState.audioUrl);
                }
              },
              icon: Icon(
                player.playing ? Icons.pause : Icons.play_arrow,
                size: 40,
              ),
            );
          },
        ),
        IconButton(
          onPressed: () async {
            await player.seek(
              Duration(seconds: player.duration!.inSeconds + 3),
            );
          },
          icon: const Icon(Icons.restore_sharp),
        ),
      ],
    );
  }
}
