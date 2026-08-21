import 'package:get/get.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<StorageService>()) {
      Get.put<StorageService>(StorageService(), permanent: true);
    }
    if (!Get.isRegistered<AudioService>()) {
      Get.put<AudioService>(AudioService(), permanent: true);
    }
  }
}
