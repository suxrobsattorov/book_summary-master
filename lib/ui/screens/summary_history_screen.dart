import 'package:book_summary/data/models/book.dart';
import 'package:book_summary/ui/widgets/book_history_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/utils/night_day.dart';
import '../../core/utils/texts.dart';
import '../../logic/blocs/audio_player/audio_player_bloc.dart';
import '../widgets/book_audio.dart';
import '../widgets/book_favorite.dart';
import '../widgets/book_info_dialog.dart';
import '../widgets/languages.dart';
import '../widgets/rate.dart';
import '../widgets/summary.dart';

class SummaryHistoryScreen extends StatefulWidget {
  const SummaryHistoryScreen({super.key});

  static const routeName = '/summary_history';

  @override
  State<SummaryHistoryScreen> createState() => _SummaryHistoryScreenState();
}

class _SummaryHistoryScreenState extends State<SummaryHistoryScreen> {
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
    final book = ModalRoute.of(context)!.settings.arguments as Book?;
    final bookSummaryEn = book != null ? book.summary : '';
    return Scaffold(
      backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
        centerTitle: true,
        title: Texts.textAppBar('Xulosa'),
        actions: [
          book != null ? BookHistoryInfoDialog(book: book) : Container(),
        ],
      ),
      body: book != null
          ? Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Languages(bookSummary: bookSummaryEn),
                      SummaryRate(currentBook: book),
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
                      BookAudio(book: book),
                      BookFavorite(book: book),
                    ],
                  ),
                )
              ],
            )
          : const Center(
              child: Text("Natija mavjud emas"),
            ),
    );
  }
}
