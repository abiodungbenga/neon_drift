import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'storage_service.dart';

class AudioService extends GetxService {
  StorageService get _storage => Get.find<StorageService>();

  final RxBool sfxEnabled = true.obs;
  final RxBool musicEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    sfxEnabled.value = _storage.isSfxEnabled;
    musicEnabled.value = _storage.isMusicEnabled;
  }

  void toggleSfx(bool value) {
    sfxEnabled.value = value;
    _storage.setSfxEnabled(value);
  }

  void toggleMusic(bool value) {
    musicEnabled.value = value;
    _storage.setMusicEnabled(value);
  }

  void playSfx(String soundFile) {
    if (!sfxEnabled.value) return;
    try {
      // FlameAudio.play(soundFile);
      // Log for fallback audio engine
      if (kDebugMode) {
        print('Playing SFX: $soundFile');
      }
    } catch (e) {
      if (kDebugMode) print('Audio playback notice: $e');
    }
  }

  void playButtonClick() => playSfx('click.mp3');
  void playCrystalCollect() => playSfx('crystal.mp3');
  void playPowerupCollect() => playSfx('powerup.mp3');
  void playCollision() => playSfx('collision.mp3');
  void playBoost() => playSfx('boost.mp3');
  void playGameOver() => playSfx('game_over.mp3');
  void playHighScore() => playSfx('high_score.mp3');
}
