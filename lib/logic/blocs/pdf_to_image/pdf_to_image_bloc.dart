import 'dart:typed_data';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';

part 'events/pdf_to_image_events.dart';
part 'states/pdf_to_image_states.dart';

class PdfToImageBloc extends Bloc<PdfToImageEvents, PdfToImageStates> {
  PdfToImageBloc() : super(InitialPdfToImageState()) {
    on<ConvertPdfToImageEvent>(_convert);
  }

  void _convert(ConvertPdfToImageEvent event, emit) async {
    final pdf = PdfImageRendererPdf(path: event.file.path);

    await pdf.open();
    int pageCount = await pdf.getPageCount();

    List<Uint8List> selectedImages = [];

    for (var i = 0; i < pageCount.clamp(0, 50); i++) {
      await pdf.openPage(pageIndex: i);
      final size = await pdf.getPageSize(pageIndex: i);
      final img = await pdf.renderPage(
        pageIndex: i,
        x: 0,
        y: 0,
        width: size.width,
        height: size.height,
        scale: 1,
        background: Colors.white,
      );
      await pdf.closePage(pageIndex: i);

      if (img != null) {
        selectedImages.add(img);
        emit(LoadingPdfToImageState(selectedImages));
      }
    }

    emit(LoadedPdfToImageState(selectedImages));

    pdf.close();
  }
}
