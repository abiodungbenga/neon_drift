import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class EnergyBarrier extends PositionComponent with CollisionCallbacks {
  final double moveSpeed;
  late final Paint _fillPaint;
  late final Paint _borderPaint;
  double _pulseTime = 0.0;

  EnergyBarrier({
    required Vector2 position,
    required Vector2 size,
    required this.moveSpeed,
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _fillPaint = Paint()
      ..color = AppColors.neonRed.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    _borderPaint = Paint()
      ..color = AppColors.neonRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 6);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    _pulseTime += dt * 5.0;

    // Move downward relative to world speed
    position.y += moveSpeed * dt;

    // Remove when out of screen bounds
    if (position.y > 1200) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(8.0),
    );

    canvas.drawRRect(rect, _fillPaint);
    canvas.drawRRect(rect, _borderPaint);

    // Hazard warning stripes
    final stripePaint = Paint()
      ..color = AppColors.neonRed.withOpacity(0.6)
      ..strokeWidth = 3.0;

    for (double x = 0; x < size.x; x += 16) {
      canvas.drawLine(Offset(x, 0), Offset(x + 10, size.y), stripePaint);
    }
  }
}
