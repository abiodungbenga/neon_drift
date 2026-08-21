import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../../../shared/models/powerup_type.dart';

class PowerUpComponent extends PositionComponent with CollisionCallbacks {
  final PowerUpType type;
  final double moveSpeed;
  double _pulseTimer = 0.0;

  late final Paint _bgPaint;
  late final Paint _borderPaint;

  PowerUpComponent({
    required Vector2 position,
    required this.type,
    required this.moveSpeed,
  }) : super(
          position: position,
          size: Vector2(36.0, 36.0),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _bgPaint = Paint()
      ..color = type.color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    _borderPaint = Paint()
      ..color = type.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 6);

    add(CircleHitbox(radius: 16.0, position: Vector2(2.0, 2.0)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    _pulseTimer += dt * 4.0;
    position.y += moveSpeed * dt;

    if (position.y > 1200) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final radius = size.x / 2;

    canvas.drawCircle(Offset(radius, radius), radius, _bgPaint);
    canvas.drawCircle(Offset(radius, radius), radius, _borderPaint);

    // Inner icon symbol representation
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(radius, radius), 6.0, iconPaint);
  }
}
