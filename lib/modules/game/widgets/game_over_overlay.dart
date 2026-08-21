import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/cyber_card.dart';
import '../../../../shared/widgets/neon_button.dart';
import '../controllers/game_controller.dart';

class GameOverOverlay extends GetView<GameController> {
  const GameOverOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final stats = controller.gameStats.value;
      if (stats == null) return const SizedBox.shrink();

      return Container(
        color: Colors.black.withOpacity(0.85),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CyberCard(
                width: 360,
                borderColor: stats.isNewHighScore ? AppColors.neonGold : AppColors.neonRed,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // New High Score Banner
                    if (stats.isNewHighScore) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.neonGold.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.neonGold),
                        ),
                        child: Text(
                          '★ NEW HIGH SCORE ★',
                          style: GoogleFonts.orbitron(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neonGold,
                            letterSpacing: 2,
                          ),
                        ),
                      ).animate().scale(duration: 400.ms, curve: Curves.bounceOut),
                      const SizedBox(height: 12),
                    ],

                    Text(
                      'GAME OVER',
                      style: GoogleFonts.orbitron(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: AppColors.neonRed,
                        letterSpacing: 3,
                        shadows: [
                          const Shadow(color: AppColors.neonRed, blurRadius: 16),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Stats Grid
                    _buildStatRow('FINAL SCORE', '${stats.finalScore}', AppColors.neonCyan),
                    const SizedBox(height: 8),
                    _buildStatRow('BEST SCORE', '${stats.highScore}', AppColors.neonGold),
                    const SizedBox(height: 8),
                    _buildStatRow('DISTANCE', '${stats.distanceMeters.toInt()} m', AppColors.neonPink),
                    const SizedBox(height: 8),
                    _buildStatRow('CRYSTALS', '${stats.crystalsCollected}', AppColors.neonGreen),

                    const SizedBox(height: 24),

                    // Action Buttons
                    NeonButton(
                      text: 'PLAY AGAIN',
                      icon: Icons.replay_rounded,
                      color: AppColors.neonCyan,
                      onPressed: controller.restartGame,
                    ),

                    const SizedBox(height: 12),

                    NeonButton(
                      text: 'MAIN MENU',
                      icon: Icons.home_rounded,
                      isSecondary: true,
                      onPressed: controller.exitToMenu,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.rajdhani(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textMuted,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.orbitron(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
