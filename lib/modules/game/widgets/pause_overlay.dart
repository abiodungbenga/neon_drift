import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/cyber_card.dart';
import '../../../../shared/widgets/neon_button.dart';
import '../controllers/game_controller.dart';

class PauseOverlay extends GetView<GameController> {
  const PauseOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.75),
      child: Center(
        child: SingleChildScrollView(
          child: CyberCard(
            width: 320,
            borderColor: AppColors.neonCyan,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PAUSED',
                  style: GoogleFonts.orbitron(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neonCyan,
                    letterSpacing: 3,
                    shadows: [
                      const Shadow(color: AppColors.neonCyan, blurRadius: 12),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                NeonButton(
                  text: 'RESUME',
                  icon: Icons.play_arrow_rounded,
                  onPressed: controller.togglePause,
                ),
                const SizedBox(height: 12),
                NeonButton(
                  text: 'RESTART',
                  icon: Icons.refresh_rounded,
                  isSecondary: true,
                  onPressed: controller.restartGame,
                ),
                const SizedBox(height: 12),
                NeonButton(
                  text: 'SETTINGS',
                  icon: Icons.settings_rounded,
                  isSecondary: true,
                  onPressed: () => Get.toNamed('/settings'),
                ),
                const SizedBox(height: 12),
                NeonButton(
                  text: 'MAIN MENU',
                  icon: Icons.home_rounded,
                  color: AppColors.neonPink,
                  onPressed: controller.exitToMenu,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
