import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class AudioService extends GetxService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> win() async {
    await _player.setReleaseMode(ReleaseMode.release);
    return _player.play(AssetSource('audio/youwon.mp3'));
  }

  Future<void> lose() async {
    await _player.setReleaseMode(ReleaseMode.release);
    return _player.play(AssetSource('audio/gameover.mp3'));
  }

  Future<void> timeisabouttoUp() async {
    await _player.setReleaseMode(ReleaseMode.release);
    return _player.play(AssetSource('audio/timeisabouttoup.mp3'));
  }

  Future<void> backgroundMusic() async {
    await _player.setReleaseMode(ReleaseMode.loop);

    await _player.play(AssetSource('audio/backgroundmusic.mp3'), volume: 0.5);

    isPlaying.value = true; // <-- ADD THIS
  }

  Future<void> stopBackgroundMusic() async {
    await _player.stop();
  }

  final isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();

    _player.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });
  }

  bool isBackgroundMusicPlaying() => isPlaying.value;

  Future<void> toggleBackgroundMusic() async {
    if (_player.state == PlayerState.playing) {
      await _player.pause();
    } else {
      await _player.resume();
    }
  }
}
