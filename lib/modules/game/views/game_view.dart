import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../controllers/game_controller.dart';
import '../widgets/game_over_overlay.dart';
import '../widgets/hud_overlay.dart';
import '../widgets/pause_overlay.dart';

class GameView extends GetView<GameController> {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final maxGameWidth = ResponsiveLayout.getGameMaxWidth(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          width: maxGameWidth,
          decoration: BoxDecoration(
            border: maxGameWidth < MediaQuery.of(context).size.width
                ? Border.symmetric(
                    vertical: BorderSide(
                      color: AppColors.neonCyan.withOpacity(0.3),
                      width: 2,
                    ),
                  )
                : null,
          ),
          child: Stack(
            children: [
              // 1. Flame Game Engine Widget
              GameWidget(game: controller.flameGame),

              // 2. HUD Overlay
              const HudOverlay(),

              // 3. Pause Overlay
              Obx(() => controller.isPaused.value
                  ? const PauseOverlay()
                  : const SizedBox.shrink()),

              // 4. Game Over Overlay
              Obx(() => controller.isGameOver.value
                  ? const GameOverOverlay()
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
