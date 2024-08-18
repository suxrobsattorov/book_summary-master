import 'package:book_summary/ui/widgets/audio_cont.dart';
import 'package:book_summary/ui/widgets/languages.dart';
import 'package:book_summary/ui/widgets/rate.dart';
import 'package:book_summary/ui/widgets/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/night_day.dart';
import '../../core/utils/texts.dart';
import '../../data/models/book.dart';
import '../../logic/blocs/all_blocs.dart';
import '../widgets/book_info_dialog.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
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
                AudioCont(),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Slider(
                    value: 1,
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                        builder: (context, audioState) {
                          return FilledButton.icon(
                            onPressed: () {
                              // if (audioState is InitialAudioPlayerState) {
                              context
                                  .read<AudioPlayerBloc>()
                                  .add(DownloadAudio(state.book.summary));
                              // }
                            },
                            label: audioState is LoadingAudioPlayerState
                                ? const SizedBox()
                                : const Text("Audio"),
                            icon: audioState is LoadingAudioPlayerState
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.play_arrow),
                          );
                        },
                      ),
                      BlocBuilder<BooksBloc, BooksState>(
                        builder: (context, booksState) {
                          if (booksState is LoadingBookState) {
                            return const CircularProgressIndicator();
                          }

                          Book currentBook = state.book;

                          if (booksState is LoadedBookState) {
                            currentBook = booksState.books.firstWhere((b) {
                              return b.id == currentBook.id;
                            });
                          }

                          return IconButton(
                            onPressed: () {
                              context.read<BooksBloc>().add(
                                    ToggleBookFavoriteEvent(currentBook.id,
                                        !currentBook.isFavorite),
                                  );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            icon: Icon(
                              currentBook.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                            ),
                          );
                        },
                      )
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
