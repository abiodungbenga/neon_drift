import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class ParticleSystem {
  static ParticleSystemComponent createExplosion({
    required Vector2 position,
    Color color = AppColors.neonPink,
    int particleCount = 20,
  }) {
    final random = math.Random();

    return ParticleSystemComponent(
      position: position,
      particle: Particle.generate(
        count: particleCount,
        lifespan: 0.6,
        generator: (i) {
          final angle = random.nextDouble() * 2 * math.pi;
          final speed = random.nextDouble() * 180 + 40;
          final velocity = Vector2(math.cos(angle) * speed, math.sin(angle) * speed);

          return AcceleratedParticle(
            speed: velocity,
            child: ComputedParticle(
              renderer: (canvas, particle) {
                final opacity = (1.0 - particle.progress).clamp(0.0, 1.0);
                final paint = Paint()
                  ..color = color.withOpacity(opacity)
                  ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);

                canvas.drawCircle(
                  Offset.zero,
                  (1.0 - particle.progress) * 5.0 + 1.0,
                  paint,
                );
              },
            ),
          );
        },
      ),
    );
  }

  static ParticleSystemComponent createCrystalSparkles({
    required Vector2 position,
  }) {
    return createExplosion(
      position: position,
      color: AppColors.neonCyan,
      particleCount: 15,
    );
  }
}
