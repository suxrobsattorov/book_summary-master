import 'package:book_summary/ui/screens/profile_screen.dart';
import 'package:day_night_themed_switch/day_night_themed_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/utils/night_day.dart';
import '../../core/utils/texts.dart';
import '../../logic/blocs/all_blocs.dart';
import '../../core/utils/constants.dart';
import '../widgets/book_pages.dart';
import '../widgets/helper_buttons.dart';
import 'summary_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double summaryLength = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: NightDay.isNight ? Colors.black : Colors.white,
        centerTitle: true,
        title: Texts.textAppBar('BUKSAM'),
        leadingWidth: 60,
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 18, bottom: 18),
          child: DayNightSwitch(
            value: NightDay.isNight,
            animationDuration: const Duration(seconds: 1),
            onChanged: (_) {
              setState(() {
                NightDay.isNight = !NightDay.isNight;
              });
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.account_circle,
              size: 26,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<GenerativeAiBloc, GenerativeAiStates>(
                  listener: (context, state) {
                    if (state is LoadedGenerativeAiState) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return const SummaryScreen();
                          },
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingGenerativeAiState) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.green.shade300,
                          size: 70,
                        ),
                      );
                    }

                    if (state is ErrorGenerativeAiState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }

                    return Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/upload_book.png',
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat,
                        width: MediaQuery.of(context).size.width - 40,
                      ),
                    );
                  },
                ),
              ),
              const BookPages(),
              Slider(
                value: summaryLength,
                min: 1,
                max: 3,
                divisions: 2,
                label: SummaryLength.values[summaryLength.toInt() - 1].name,
                onChanged: (value) {
                  setState(() {
                    summaryLength = value;
                  });
                },
              ),
              BlocBuilder<PdfToImageBloc, PdfToImageStates>(
                builder: (context, state) {
                  return HelperButtons(
                    firstButtonClick: () {
                      context.read<FilePickerBloc>().add(SelectFileEvent());
                    },
                    secondButtonClick: state is LoadedPdfToImageState
                        ? () {
                            context.read<GenerativeAiBloc>().add(
                                  SummarizeAiEvent(
                                    state.files,
                                    SummaryLength
                                        .values[summaryLength.toInt() - 1],
                                  ),
                                );
                          }
                        : null,
                    firstButtonLabel: "UPLOAD",
                    secondButtonLabel: "SEND",
                    firstIcon: Icons.cloud_upload,
                    secondIcon: Icons.send,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
