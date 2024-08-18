part of '../pdf_to_image_bloc.dart';

sealed class PdfToImageEvents {}

final class ConvertPdfToImageEvent extends PdfToImageEvents {
  final File file;

  ConvertPdfToImageEvent(this.file);
}
