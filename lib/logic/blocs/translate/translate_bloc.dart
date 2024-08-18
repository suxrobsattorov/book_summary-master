import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'translate_events.dart';

part 'translate_states.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(InitialTranslate()) {
    on<ConvertTranslateEvent>(_translate);
  }

  void _translate(ConvertTranslateEvent event, emit) async {
    emit(LoadingTranslate());
    final url = Uri.parse(
        'https://deep-translate1.p.rapidapi.com/language/translate/v2');

    try {
      final response = await http.post(
        url,
        headers: {
          "x-rapidapi-key":
              "ef62cb7990msh454b3c50a0ea660p17d04cjsn0dedc0b170f6",
          "x-rapidapi-host": "deep-translate1.p.rapidapi.com",
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {"q": event.text, "source": "en", "target": event.language},
        ),
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body) as Map<String, dynamic>;
        emit(LoadedTranslate(res['data']['translations']['translatedText']));
      }
    } catch (e) {
      emit(ErrorTranslate(e.toString()));
    }
  }
}
