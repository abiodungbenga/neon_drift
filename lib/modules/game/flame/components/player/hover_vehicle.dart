import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class HoverVehicle extends PositionComponent with CollisionCallbacks {
  final Vector2 gameSize;

  // Movement & Physics
  Vector2 velocity = Vector2.zero();
  double speed = 400.0;
  double tiltAngle = 0.0;
  double maxTilt = 0.35; // radians (~20 degrees)
  
  // Health & Power-up states
  bool isShielded = false;
  bool isBoosted = false;
  bool isHitFlash = false;
  double _hitFlashTimer = 0.0;

  // Visual Paints
  late final Paint _bodyPaint;
  late final Paint _glowPaint;
  late final Paint _thrusterPaint;
  late final Paint _shieldPaint;

  HoverVehicle({required this.gameSize})
      : super(
          size: Vector2(48.0, 72.0),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Initial position: Bottom-center of playable canvas
    position = Vector2(gameSize.x / 2, gameSize.y * 0.82);

    _bodyPaint = Paint()
      ..color = AppColors.neonCyan
      ..style = PaintingStyle.fill;

    _glowPaint = Paint()
      ..color = AppColors.neonCyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 6);

    _thrusterPaint = Paint()
      ..color = AppColors.neonPink
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 8);

    _shieldPaint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 8);

    // Collision box setup
    add(RectangleHitbox(size: Vector2(36.0, 56.0), position: Vector2(6.0, 8.0)));
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move player based on velocity
    final currentSpeed = isBoosted ? speed * 1.5 : speed;
    position += velocity * currentSpeed * dt;

    // Constrain inside playing screen bounds
    final halfWidth = size.x / 2;
    final halfHeight = size.y / 2;

    position.x = position.x.clamp(halfWidth, gameSize.x - halfWidth);
    position.y = position.y.clamp(gameSize.y * 0.2, gameSize.y - halfHeight - 10);

    // Dynamic Banking Tilt Interpolation
    final targetTilt = (velocity.x / 1.0).clamp(-1.0, 1.0) * maxTilt;
    tiltAngle += (targetTilt - tiltAngle) * 10.0 * dt;
    angle = tiltAngle;

    // Hit flash timer
    if (isHitFlash) {
      _hitFlashTimer -= dt;
      if (_hitFlashTimer <= 0) {
        isHitFlash = false;
      }
    }
  }

  void triggerHitEffect() {
    isHitFlash = true;
    _hitFlashTimer = 0.3;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final w = size.x;
    final h = size.y;

    if (isHitFlash) {
      // White hit flash
      final flashPaint = Paint()..color = Colors.white;
      final path = Path()
        ..moveTo(w / 2, 0)
        ..lineTo(w, h * 0.75)
        ..lineTo(w * 0.7, h)
        ..lineTo(w * 0.3, h)
        ..lineTo(0, h * 0.75)
        ..close();
      canvas.drawPath(path, flashPaint);
      return;
    }

    // 1. Thruster Glow
    final thrusterLength = isBoosted ? h * 0.5 : h * 0.25;
    final thrusterPath = Path()
      ..moveTo(w * 0.35, h * 0.9)
      ..lineTo(w / 2, h * 0.9 + thrusterLength)
      ..lineTo(w * 0.65, h * 0.9)
      ..close();
    
    _thrusterPaint.color = isBoosted ? AppColors.neonGold : AppColors.neonPink;
    canvas.drawPath(thrusterPath, _thrusterPaint);

    // 2. Futuristic Hovercraft Body Shape
    final bodyPath = Path()
      ..moveTo(w / 2, 0) // Nose tip
      ..lineTo(w * 0.9, h * 0.65) // Right wing
      ..lineTo(w * 0.75, h * 0.95) // Right rear
      ..lineTo(w * 0.5, h * 0.85) // Center cockpit indent
      ..lineTo(w * 0.25, h * 0.95) // Left rear
      ..lineTo(w * 0.1, h * 0.65) // Left wing
      ..close();

    // Body Fill & Glow
    _bodyPaint.color = isBoosted ? AppColors.neonGold : AppColors.neonCyan;
    _glowPaint.color = isBoosted ? AppColors.neonGold : AppColors.neonCyan;

    canvas.drawPath(bodyPath, _bodyPaint);
    canvas.drawPath(bodyPath, _glowPaint);

    // Cockpit Canopy
    final cockpitPaint = Paint()..color = AppColors.background;
    canvas.drawOval(
      Rect.fromLTWH(w * 0.35, h * 0.3, w * 0.3, h * 0.35),
      cockpitPaint,
    );

    // 3. Shield Bubble Visual Layer
    if (isShielded) {
      final shieldRadius = math.max(w, h) * 0.65;
      canvas.drawCircle(Offset(w / 2, h / 2), shieldRadius, _shieldPaint);
    }
  }
}
