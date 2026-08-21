import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class EnergyCrystal extends PositionComponent with CollisionCallbacks {
  final double moveSpeed;
  final Vector2 Function()? getPlayerPosition;
  final bool Function()? isMagnetActive;

  double _rotationAngle = 0.0;
  late final Paint _crystalPaint;
  late final Paint _glowPaint;

  EnergyCrystal({
    required Vector2 position,
    required this.moveSpeed,
    this.getPlayerPosition,
    this.isMagnetActive,
  }) : super(
          position: position,
          size: Vector2(28.0, 28.0),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _crystalPaint = Paint()
      ..color = AppColors.neonCyan
      ..style = PaintingStyle.fill;

    _glowPaint = Paint()
      ..color = AppColors.neonCyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 6);

    add(CircleHitbox(radius: 12.0, position: Vector2(2.0, 2.0)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    _rotationAngle += dt * 3.0;

    // Magnet Attraction Physics
    if (isMagnetActive != null && isMagnetActive!() && getPlayerPosition != null) {
      final playerPos = getPlayerPosition!();
      final diff = playerPos - position;
      final distance = diff.length;

      if (distance < 220.0) {
        // Move towards player smoothly
        final direction = diff.normalized();
        position += direction * (500.0 * dt);
      } else {
        position.y += moveSpeed * dt;
      }
    } else {
      position.y += moveSpeed * dt;
    }

    if (position.y > 1200) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final w = size.x;
    final h = size.y;

    canvas.save();
    canvas.translate(w / 2, h / 2);
    canvas.rotate(_rotationAngle);

    // Glowing Diamond Path
    final path = Path()
      ..moveTo(0, -h / 2)
      ..lineTo(w / 2, 0)
      ..lineTo(0, h / 2)
      ..lineTo(-w / 2, 0)
      ..close();

    canvas.drawPath(path, _crystalPaint);
    canvas.drawPath(path, _glowPaint);

    canvas.restore();
  }
}
