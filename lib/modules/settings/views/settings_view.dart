import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/cyber_card.dart';
import '../../../shared/widgets/neon_button.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.cyberBackground),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.neonCyan),
                      onPressed: () => Get.back(),
                    ),
                    Expanded(
                      child: Text(
                        'SETTINGS',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.orbitron(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.neonCyan,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance back button
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Column(
                        children: [
                          CyberCard(
                            borderColor: AppColors.neonPurple,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AUDIO PREFERENCES',
                                  style: GoogleFonts.orbitron(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.neonCyan,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Obx(() => SwitchListTile(
                                      title: const Text('Sound Effects (SFX)'),
                                      subtitle: const Text('Collisions, crystals, powerup audio'),
                                      value: controller.isSfxEnabled.value,
                                      activeColor: AppColors.neonCyan,
                                      onChanged: controller.toggleSfx,
                                    )),
                                const Divider(color: AppColors.cardBg),
                                Obx(() => SwitchListTile(
                                      title: const Text('Background Synth Music'),
                                      subtitle: const Text('Futuristic soundtrack loop'),
                                      value: controller.isMusicEnabled.value,
                                      activeColor: AppColors.neonPink,
                                      onChanged: controller.toggleMusic,
                                    )),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          CyberCard(
                            borderColor: AppColors.neonRed,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DATA MANAGEMENT',
                                  style: GoogleFonts.orbitron(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.neonRed,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reset High Score',
                                            style: GoogleFonts.rajdhani(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          Text(
                                            'Clears local high score record',
                                            style: GoogleFonts.rajdhani(
                                              fontSize: 13,
                                              color: AppColors.textMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    NeonButton(
                                      text: 'RESET',
                                      width: 100,
                                      height: 40,
                                      color: AppColors.neonRed,
                                      onPressed: controller.resetHighScore,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          NeonButton(
                            text: 'BACK TO MENU',
                            icon: Icons.arrow_back_rounded,
                            width: 220,
                            isSecondary: true,
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
