import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../shared/models/powerup_type.dart';
import '../controllers/game_controller.dart';

class HudOverlay extends GetView<GameController> {
  const HudOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb || ResponsiveLayout.isDesktop(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            // Top HUD Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Score & Best
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SCORE', style: AppTextStyles.hudLabel),
                        Text(
                          '${controller.score.value}',
                          style: AppTextStyles.hudValue,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'BEST: ${controller.highScore.value}',
                          style: GoogleFonts.rajdhani(
                            fontSize: 12.0,
                            color: AppColors.neonGold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),

                // Distance Traveled
                Obx(() => Column(
                      children: [
                        Text('DISTANCE', style: AppTextStyles.hudLabel),
                        Text(
                          '${controller.distanceMeters.value.toInt()} m',
                          style: GoogleFonts.orbitron(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neonPink,
                          ),
                        ),
                      ],
                    )),

                // Pause Button
                IconButton(
                  onPressed: controller.togglePause,
                  icon: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.neonCyan),
                    ),
                    child: const Icon(
                      Icons.pause_rounded,
                      color: AppColors.neonCyan,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Health & Energy Progress Bars
            Row(
              children: [
                // Health Bar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('HEALTH', style: AppTextStyles.hudLabel),
                          Obx(() => Text(
                                '${controller.health.value.toInt()}%',
                                style: GoogleFonts.rajdhani(
                                  color: AppColors.neonRed,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Obx(() => LinearProgressIndicator(
                            value: (controller.health.value / 100.0).clamp(0.0, 1.0),
                            backgroundColor: AppColors.cardBg,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.neonRed),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                          )),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Energy Bar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ENERGY', style: AppTextStyles.hudLabel),
                          Obx(() => Text(
                                '${controller.energy.value.toInt()}%',
                                style: GoogleFonts.rajdhani(
                                  color: AppColors.neonCyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Obx(() => LinearProgressIndicator(
                            value: (controller.energy.value / 100.0).clamp(0.0, 1.0),
                            backgroundColor: AppColors.cardBg,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.neonCyan),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                          )),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Active Power-Up Display & Platform Control Hint
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Control Hint Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.glassBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.neonPurple.withOpacity(0.5)),
                  ),
                  child: Text(
                    isDesktop ? 'WASD / ARROWS TO STEER' : 'DRAG TO STEER',
                    style: GoogleFonts.rajdhani(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),

                // Active Power-Up Banner
                Obx(() {
                  final p = controller.activePowerUp.value;
                  if (p == null) return const SizedBox.shrink();

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: p.color.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: p.color, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Icon(p.icon, color: p.color, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          '${p.title} (${controller.powerUpRemaining.value.toStringAsFixed(1)}s)',
                          style: GoogleFonts.orbitron(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
