import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../logic/blocs/all_blocs.dart';

class BookPages extends StatelessWidget {
  const BookPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilePickerBloc, FilePickerStates>(
      listener: (context, state) {
        if (state is LoadedFilePickerState) {
          if (state.file != null) {
            context
                .read<PdfToImageBloc>()
                .add(ConvertPdfToImageEvent(state.file!));
          }
        }
      },
      builder: (context, state) {
        if (state is LoadedFilePickerState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height/2-100,
            child: BlocBuilder<PdfToImageBloc, PdfToImageStates>(
              builder: (context, state) {
                if (state is ErrorPdfToImageState) {
                  return const Center(
                    child: Text("Fayl yuklanishda xatolik"),
                  );
                }

                if (state is LoadingPdfToImageState ||
                    state is LoadedPdfToImageState) {
                  final files = state is LoadedPdfToImageState
                      ? state.files
                      : (state as LoadingPdfToImageState).files;

                  return MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: files.length,
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 150,
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              files[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
