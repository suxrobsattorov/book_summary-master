import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AudioService {
  Future<String> downloadAudio(String summary) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        "https://api.v7.unrealspeech.com/speech",
        data: {
          "Text": summary,
          "VoiceId": "Dan",
          "Bitrate": "192k",
          "Speed": "0",
          "Pitch": "1",
          "TimestampType": "sentence"
        },
        options: Options(headers: {
          "Authorization":
              "Bearer 8oAduIeCUREzE1UgSTcoxzF3HaLhbc2q8khfOHhEhuSYXPoZEceq93",
          "x-rapidapi-host": "open-ai-text-to-speech1.p.rapidapi.com",
          "Content-Type": "application/json",
        }),
      );

      final summaryAudioUrl = response.data['OutputUri'];

      final audioResponse = await dio.get(summaryAudioUrl,
          options: Options(
            responseType: ResponseType.bytes,
          ));

      final firebaseAudioUrl = await uploadToFirebase(audioResponse.data);

      return firebaseAudioUrl;
    } on FirebaseException catch (e) {
      print(e.message);
      throw (e.message ?? 'Unknown Error');
    } on DioException catch (e) {
      throw (e.response!.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadToFirebase(Uint8List audioBytes) async {
    final ref = FirebaseStorage.instance.ref();
    final filename = UniqueKey().toString();
    final path = ref.child("audios").child("$filename.mp3");
    final uploadTask = path.putData(audioBytes);

    uploadTask.snapshotEvents.listen((taskData) {
      print(taskData.bytesTransferred / taskData.totalBytes);
    });
    await uploadTask.whenComplete(() {});
    return await path.getDownloadURL();
  }
}
