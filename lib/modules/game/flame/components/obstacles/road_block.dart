import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class RoadBlock extends PositionComponent with CollisionCallbacks {
  final double moveSpeed;
  late final Paint _fillPaint;
  late final Paint _strokePaint;

  RoadBlock({
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
      ..color = AppColors.cardBg
      ..style = PaintingStyle.fill;

    _strokePaint = Paint()
      ..color = AppColors.neonPurple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += moveSpeed * dt;

    if (position.y > 1200) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(6.0),
    );

    canvas.drawRRect(rect, _fillPaint);
    canvas.drawRRect(rect, _strokePaint);
  }
}
