import 'dart:math' as math;
import 'package:flame/components.dart';

class ScreenShake extends Component {
  final CameraComponent camera;
  double duration;
  double intensity;
  double _elapsed = 0.0;
  final math.Random _random = math.Random();

  ScreenShake({
    required this.camera,
    this.duration = 0.3,
    this.intensity = 12.0,
  });

  @override
  void update(double dt) {
    super.update(dt);
    _elapsed += dt;

    if (_elapsed < duration) {
      final offsetX = (_random.nextDouble() * 2 - 1) * intensity;
      final offsetY = (_random.nextDouble() * 2 - 1) * intensity;
      camera.viewfinder.position += Vector2(offsetX, offsetY);
    } else {
      removeFromParent();
    }
  }
}
