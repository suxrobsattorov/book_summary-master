import 'package:book_summary/data/models/book.dart';
import 'package:book_summary/ui/widgets/book_audio.dart';
import 'package:book_summary/ui/widgets/book_favorite.dart';
import 'package:book_summary/ui/widgets/languages.dart';
import 'package:book_summary/ui/widgets/rate.dart';
import 'package:book_summary/ui/widgets/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/utils/night_day.dart';
import '../../core/utils/texts.dart';
import '../../logic/blocs/all_blocs.dart';
import '../widgets/book_info_dialog.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  static const routeName = '/summary';

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final player = AudioPlayer();

  void play(String url) async {
    if (player.playing) {
      player.pause();
    } else {
      await player.setUrl(url);
      player.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
        centerTitle: true,
        title: Texts.textAppBar('Xulosa'),
        actions: const [
          BookInfoDialog(),
        ],
      ),
      body: BlocBuilder<GenerativeAiBloc, GenerativeAiStates>(
        builder: (context, state) {
          if (state is LoadedGenerativeAiState) {
            String bookSummaryEn = state.book.summary;
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Languages(bookSummary: bookSummaryEn),
                      SummaryRate(currentBook: state.book),
                    ],
                  ),
                ),
                Summary(bookSummaryEn: bookSummaryEn),
                Center(
                  child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                    builder: (context, audioState) {
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
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BookAudio(book: state.book),
                      BookFavorite(book: state.book),
                    ],
                  ),
                )
              ],
            );
          }
          return const Center(
            child: Text("Natija mavjud emas"),
          );
        },
      ),
    );
  }
}
