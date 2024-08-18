part of '../file_picker_bloc.dart';

sealed class FilePickerStates {}

final class InitialFilePickerState extends FilePickerStates {}

final class LoadingFilePickerState extends FilePickerStates {}

final class LoadedFilePickerState extends FilePickerStates {
  final File? file;

  LoadedFilePickerState(this.file);
}

final class ErrorFilePickerState extends FilePickerStates {}
