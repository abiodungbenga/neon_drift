import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class LaserGate extends PositionComponent with CollisionCallbacks {
  final double moveSpeed;
  bool isActive = true;
  double _toggleTimer = 0.0;
  final double toggleInterval = 1.5;

  late final RectangleHitbox _hitbox;
  late final Paint _laserPaint;
  late final Paint _emitterPaint;

  LaserGate({
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

    _laserPaint = Paint()
      ..color = AppColors.neonPink
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 8);

    _emitterPaint = Paint()
      ..color = AppColors.neonCyan
      ..style = PaintingStyle.fill;

    _hitbox = RectangleHitbox();
    add(_hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += moveSpeed * dt;

    _toggleTimer += dt;
    if (_toggleTimer >= toggleInterval) {
      _toggleTimer = 0.0;
      isActive = !isActive;
      if (isActive) {
        if (!children.contains(_hitbox)) add(_hitbox);
      } else {
        if (children.contains(_hitbox)) remove(_hitbox);
      }
    }

    if (position.y > 1200) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Render Emitters on left and right ends
    canvas.drawCircle(Offset(10, size.y / 2), 12, _emitterPaint);
    canvas.drawCircle(Offset(size.x - 10, size.y / 2), 12, _emitterPaint);

    if (isActive) {
      // Beam
      final beamRect = Rect.fromLTWH(18, size.y / 2 - 4, size.x - 36, 8);
      canvas.drawRect(beamRect, _laserPaint);
    } else {
      // Warning dotted pulse line
      final warnPaint = Paint()
        ..color = AppColors.neonPink.withOpacity(0.3)
        ..strokeWidth = 2.0;

      for (double x = 20; x < size.x - 20; x += 12) {
        canvas.drawLine(Offset(x, size.y / 2), Offset(x + 6, size.y / 2), warnPaint);
      }
    }
  }
}
