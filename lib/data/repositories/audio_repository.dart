
import '../services/audio_service.dart';

class AudioRepository {
  final AudioService _audioService;

  AudioRepository({required AudioService audioService})
      : _audioService = audioService;

  Future<String> downloadAudio(String summary) async {
    return await _audioService.downloadAudio(summary);
  }
}
