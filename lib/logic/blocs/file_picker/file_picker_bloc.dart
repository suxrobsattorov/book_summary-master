import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';

part 'events/file_picker_events.dart';
part 'states/file_picker_states.dart';

class FilePickerBloc extends Bloc<FilePickerEvents, FilePickerStates> {
  FilePickerBloc() : super(InitialFilePickerState()) {
    // hodisani e'lon qilib ketamiz
    on<SelectFileEvent>(_selectFile);
  }

  void _selectFile(SelectFileEvent event, emit) async {
    emit(LoadingFilePickerState());

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    final selectedFile =
        result != null ? File(result.files.single.path!) : null;

    emit(LoadedFilePickerState(selectedFile));
  }
}
