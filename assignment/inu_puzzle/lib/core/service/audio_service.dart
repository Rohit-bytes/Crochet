import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioService extends GetxService {
  final AudioPlayer _player = AudioPlayer();

  final isSoundEnabled = true.obs;

  Future<void> win() async {
    if (!isSoundEnabled.value) return;

    await _player.setReleaseMode(ReleaseMode.release);
    await _player.play(AssetSource('audio/youwon.mp3'));
  }

  Future<void> lose() async {
    if (!isSoundEnabled.value) return;

    await _player.setReleaseMode(ReleaseMode.release);
    await _player.play(AssetSource('audio/gameover.mp3'));
  }

  Future<void> timeisabouttoUp() async {
    if (!isSoundEnabled.value) return;

    await _player.setReleaseMode(ReleaseMode.release);
    await _player.play(AssetSource('audio/timeisabouttoup.mp3'));
  }

  Future<void> backgroundMusic() async {
    if (!isSoundEnabled.value) return;

    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('audio/backgroundmusic.mp3'), volume: 0.5);
  }

  Future<void> toggleSound() async {
    isSoundEnabled.toggle();

    if (!isSoundEnabled.value) {
      // Mute everything
      await _player.stop();
    } else {
      // Start background music again
      await backgroundMusic();
    }
  }
}
