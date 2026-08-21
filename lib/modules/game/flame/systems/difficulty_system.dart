import 'dart:math' as math;
import '../../../../core/constants/game_constants.dart';

class DifficultySystem {
  double currentSpeed = GameConstants.initialWorldSpeed;
  double elapsedTime = 0.0;
  double distanceMeters = 0.0;
  int currentLevel = 1;

  void update(double dt) {
    elapsedTime += dt;

    // Smoothly scale world speed based on elapsed survival time
    currentSpeed = math.min(
      GameConstants.maxWorldSpeed,
      GameConstants.initialWorldSpeed + elapsedTime * GameConstants.speedIncreaseRate,
    );

    // Distance accumulated in meters
    distanceMeters += (currentSpeed * dt) / 10.0;

    // Difficulty level calculation (1 to 10)
    currentLevel = (1 + (elapsedTime / 15.0)).floor().clamp(1, 10);
  }

  double get obstacleSpawnInterval {
    // Decreases spawn interval as level increases
    return math.max(
      GameConstants.minObstacleSpawnInterval,
      GameConstants.baseObstacleSpawnInterval - (currentLevel * 0.1),
    );
  }

  void reset() {
    currentSpeed = GameConstants.initialWorldSpeed;
    elapsedTime = 0.0;
    distanceMeters = 0.0;
    currentLevel = 1;
  }
}
