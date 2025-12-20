import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playClick() async {
    await _player.stop();
    await _player.play(
      AssetSource('sounds/click.mp3'),
      volume: 0.8,
    );
  }
}
