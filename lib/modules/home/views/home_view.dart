import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/cyber_card.dart';
import '../../../shared/widgets/neon_button.dart';
import '../../../shared/widgets/neon_title.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.cyberBackground,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Animated Neon Title
                  const NeonTitle()
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .slideY(begin: -0.2, end: 0.0, curve: Curves.easeOutQuad),

                  const SizedBox(height: 32),

                  // High Score Pill Banner
                  CyberCard(
                    width: 280,
                    borderColor: AppColors.neonGold,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.emoji_events_rounded, color: AppColors.neonGold, size: 22),
                        const SizedBox(width: 10),
                        Text(
                          'HIGH SCORE: ',
                          style: GoogleFonts.rajdhani(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMuted,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Obx(() => Text(
                              '${controller.highScore.value}',
                              style: GoogleFonts.orbitron(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.neonGold,
                              ),
                            )),
                      ],
                    ),
                  ).animate().scale(delay: 300.ms, duration: 500.ms),

                  const SizedBox(height: 48),

                  // Action Buttons
                  NeonButton(
                    text: 'PLAY GAME',
                    icon: Icons.play_arrow_rounded,
                    width: 260,
                    height: 58,
                    color: AppColors.neonCyan,
                    onPressed: controller.startGame,
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0.0),

                  const SizedBox(height: 16),

                  NeonButton(
                    text: 'HOW TO PLAY',
                    icon: Icons.help_outline_rounded,
                    width: 260,
                    isSecondary: true,
                    onPressed: controller.openHowToPlay,
                  ).animate().fadeIn(delay: 650.ms).slideY(begin: 0.2, end: 0.0),

                  const SizedBox(height: 16),

                  NeonButton(
                    text: 'SETTINGS',
                    icon: Icons.settings_rounded,
                    width: 260,
                    isSecondary: true,
                    onPressed: controller.openSettings,
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0.0),

                  const SizedBox(height: 60),

                  // Version Tag Footer
                  Text(
                    'NEON DRIFT V1.0.0',
                    style: GoogleFonts.rajdhani(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
