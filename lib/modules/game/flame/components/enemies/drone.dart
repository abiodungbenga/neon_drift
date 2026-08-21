import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class EnemyDrone extends PositionComponent with CollisionCallbacks {
  final double moveSpeed;
  final double initialX;
  final double sweepAmplitude;
  double _time = 0.0;

  late final Paint _dronePaint;
  late final Paint _eyePaint;

  EnemyDrone({
    required Vector2 position,
    required this.moveSpeed,
    this.sweepAmplitude = 60.0,
  })  : initialX = position.x,
        super(
          position: position,
          size: Vector2(40.0, 40.0),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _dronePaint = Paint()
      ..color = AppColors.neonRed
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);

    _eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    add(CircleHitbox(radius: 18.0, position: Vector2(2.0, 2.0)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt * 3.0;

    // Move down & sweep side to side
    position.y += moveSpeed * 1.15 * dt;
    position.x = initialX + math.sin(_time) * sweepAmplitude;

    if (position.y > 1200) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final w = size.x;
    final h = size.y;

    // Diamond / Drone Wing Shape
    final path = Path()
      ..moveTo(w / 2, 0)
      ..lineTo(w, h / 2)
      ..lineTo(w / 2, h)
      ..lineTo(0, h / 2)
      ..close();

    canvas.drawPath(path, _dronePaint);

    // Glowing red eye in middle
    canvas.drawCircle(Offset(w / 2, h / 2), 6.0, _eyePaint);
  }
}
