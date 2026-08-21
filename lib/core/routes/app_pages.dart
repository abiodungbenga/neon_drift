import 'package:get/get.dart';
import '../../modules/game/bindings/game_binding.dart';
import '../../modules/game/views/game_view.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/how_to_play/bindings/how_to_play_binding.dart';
import '../../modules/how_to_play/views/how_to_play_view.dart';
import '../../modules/settings/bindings/settings_binding.dart';
import '../../modules/settings/views/settings_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.GAME,
      page: () => const GameView(),
      binding: GameBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.HOW_TO_PLAY,
      page: () => const HowToPlayView(),
      binding: HowToPlayBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
