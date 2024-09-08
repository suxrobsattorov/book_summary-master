import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book.dart';
import '../../logic/blocs/all_blocs.dart';

class BookAudio extends StatelessWidget {
  Book book;

  BookAudio({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, audioState) {
        return FilledButton.icon(
          onPressed: () {
            context.read<AudioPlayerBloc>().add(DownloadAudio(book.summary));
          },
          label: audioState is LoadingAudioPlayerState
              ? const SizedBox()
              : const Text("Audio"),
          icon: audioState is LoadingAudioPlayerState
              ? const CircularProgressIndicator(color: Colors.white)
              : const Icon(Icons.play_arrow),
        );
      },
    );
  }
}
