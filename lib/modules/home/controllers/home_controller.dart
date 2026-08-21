import 'package:get/get.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/services/storage_service.dart';

class HomeController extends GetxController {
  final StorageService storage = Get.find<StorageService>();
  final AudioService audio = Get.find<AudioService>();

  final highScore = 0.obs;

  @override
  void onInit() {
    super.onInit();
    highScore.value = storage.highScore;
  }

  void startGame() {
    audio.playButtonClick();
    Get.toNamed('/game');
  }

  void openHowToPlay() {
    audio.playButtonClick();
    Get.toNamed('/how-to-play');
  }

  void openSettings() {
    audio.playButtonClick();
    Get.toNamed('/settings');
  }
}
