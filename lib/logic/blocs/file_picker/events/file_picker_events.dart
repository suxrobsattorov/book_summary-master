part of '../file_picker_bloc.dart';

// sealed - abstract faqat shu faylda ishlaydi
sealed class FilePickerEvents {}

// final - bunday class'dan nasil olib bo'lmaydi faqat obyekt yaratish mumkin
final class SelectFileEvent extends FilePickerEvents {}
