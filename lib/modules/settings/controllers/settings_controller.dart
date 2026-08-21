import 'package:get/get.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/services/storage_service.dart';

class SettingsController extends GetxController {
  final StorageService storage = Get.find<StorageService>();
  final AudioService audio = Get.find<AudioService>();

  final isSfxEnabled = true.obs;
  final isMusicEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    isSfxEnabled.value = storage.isSfxEnabled;
    isMusicEnabled.value = storage.isMusicEnabled;
  }

  void toggleSfx(bool value) {
    isSfxEnabled.value = value;
    audio.toggleSfx(value);
  }

  void toggleMusic(bool value) {
    isMusicEnabled.value = value;
    audio.toggleMusic(value);
  }

  Future<void> resetHighScore() async {
    await storage.resetHighScore();
    audio.playButtonClick();
    Get.snackbar(
      'SETTINGS',
      'High Score has been reset',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.surface,
      colorText: Get.theme.colorScheme.onSurface,
    );
  }
}
