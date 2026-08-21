import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/models/powerup_type.dart';
import '../../../shared/widgets/cyber_card.dart';
import '../../../shared/widgets/neon_button.dart';
import '../controllers/how_to_play_controller.dart';

class HowToPlayView extends GetView<HowToPlayController> {
  const HowToPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.cyberBackground),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
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
                        'HOW TO PLAY',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.orbitron(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.neonCyan,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 550),
                      child: Column(
                        children: [
                          // 1. Controls Card
                          CyberCard(
                            borderColor: AppColors.neonCyan,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader('CONTROLS', Icons.gamepad_rounded, AppColors.neonCyan),
                                const SizedBox(height: 12),
                                _buildItemRow('Mobile Touch', 'Drag / swipe anywhere on screen to steer your vehicle.'),
                                const SizedBox(height: 8),
                                _buildItemRow('Web / Desktop', 'Use WASD or Arrow Keys to steer precision paths.'),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // 2. Gameplay Objectives Card
                          CyberCard(
                            borderColor: AppColors.neonPink,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader('OBJECTIVE & HEALTH', Icons.favorite_rounded, AppColors.neonPink),
                                const SizedBox(height: 12),
                                _buildItemRow('Survive Speed', 'Drift down the cyber grid as speed dynamically scales up.'),
                                const SizedBox(height: 8),
                                _buildItemRow('Energy Decay', 'Energy constantly drains. Collect glowing crystals to recharge energy!'),
                                const SizedBox(height: 8),
                                _buildItemRow('Avoid Hazards', 'Crashing into barriers, gates, or drones costs 25% health.'),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // 3. Power-ups Card
                          CyberCard(
                            borderColor: AppColors.neonGold,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader('POWER-UPS', Icons.bolt_rounded, AppColors.neonGold),
                                const SizedBox(height: 12),
                                for (final p in PowerUpType.values) ...[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(p.icon, color: p.color, size: 20),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              p.title,
                                              style: GoogleFonts.orbitron(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: p.color,
                                              ),
                                            ),
                                            Text(
                                              p.description,
                                              style: GoogleFonts.rajdhani(
                                                fontSize: 13,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ],
                            ),
                          ),

                          const SizedBox(height: 28),

                          NeonButton(
                            text: 'READY TO DRIFT',
                            icon: Icons.play_arrow_rounded,
                            width: 240,
                            onPressed: () => Get.offNamed('/game'),
                          ),

                          const SizedBox(height: 20),
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

  Widget _buildHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.orbitron(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildItemRow(String label, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.rajdhani(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          desc,
          style: GoogleFonts.rajdhani(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
