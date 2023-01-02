import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final player = AudioPlayer();

  static Future playAudio(String filename) async {
    await player.play(AssetSource('audio/$filename.mp3'));
  }
}
