import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class MotionTrail extends Component {
  final Vector2 Function() getPlayerPosition;
  final bool Function() isBoosted;
  final List<Vector2> _points = [];
  final int maxPoints = 20;

  late final Paint _trailPaint;

  MotionTrail({
    required this.getPlayerPosition,
    required this.isBoosted,
  }) {
    _trailPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final pos = getPlayerPosition();
    _points.insert(0, pos.clone());
    if (_points.length > maxPoints) {
      _points.removeLast();
    }
  }

  @override
  void render(Canvas canvas) {
    if (_points.length < 2) return;

    final color = isBoosted() ? AppColors.neonGold : AppColors.neonCyan;
    
    for (int i = 0; i < _points.length - 1; i++) {
      final opacity = (1.0 - (i / _points.length)).clamp(0.0, 1.0);
      _trailPaint.color = color.withOpacity(opacity * 0.7);
      _trailPaint.strokeWidth = mathMax(1.0, 6.0 * opacity);
      
      canvas.drawLine(_points[i].toOffset(), _points[i + 1].toOffset(), _trailPaint);
    }
  }

  double mathMax(double a, double b) => a > b ? a : b;
}
