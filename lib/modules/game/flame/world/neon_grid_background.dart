import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class NeonGridBackground extends Component {
  final Vector2 gameSize;
  final double Function() getWorldSpeed;
  double _gridOffsetY = 0.0;

  late final Paint _linePaint;
  late final Paint _horizonPaint;
  late final Paint _sunPaint;

  NeonGridBackground({
    required this.gameSize,
    required this.getWorldSpeed,
  }) {
    _linePaint = Paint()
      ..color = AppColors.neonPurple.withOpacity(0.35)
      ..strokeWidth = 1.5;

    _horizonPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF070712), Color(0xFF1B0933)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, 1000, 1000));

    _sunPaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.neonPink, AppColors.neonGold],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, 180, 180))
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 12);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _gridOffsetY = (_gridOffsetY + getWorldSpeed() * dt) % 60.0;
  }

  @override
  void render(Canvas canvas) {
    final width = gameSize.x;
    final height = gameSize.y;

    // 1. Dark Synthwave Gradient Background
    final bgRect = Rect.fromLTWH(0, 0, width, height);
    canvas.drawRect(bgRect, _horizonPaint);

    // 2. Horizon Sun at the top center
    final sunRadius = width > 600 ? 90.0 : 60.0;
    canvas.drawCircle(Offset(width / 2, height * 0.15), sunRadius, _sunPaint);

    // 3. Perspective Grid Lines (Vertical Lane Markers)
    final numLanes = 7;
    final vanishingPoint = Offset(width / 2, height * 0.15);

    for (int i = 0; i <= numLanes; i++) {
      final bottomX = (width / numLanes) * i;
      canvas.drawLine(vanishingPoint, Offset(bottomX, height), _linePaint);
    }

    // 4. Horizontal Scrolling Perspective Grid Lines
    for (double y = height * 0.2; y <= height; y += 40.0) {
      final drawY = y + _gridOffsetY;
      if (drawY <= height) {
        // Fade out lines near top horizon
        final progress = (drawY - height * 0.2) / (height * 0.8);
        _linePaint.color = AppColors.neonPurple.withOpacity((progress * 0.4).clamp(0.0, 0.4));
        canvas.drawLine(Offset(0, drawY), Offset(width, drawY), _linePaint);
      }
    }
  }
}
