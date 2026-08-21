import 'package:get/get.dart';
import '../controllers/how_to_play_controller.dart';

class HowToPlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HowToPlayController>(() => HowToPlayController());
  }
}
