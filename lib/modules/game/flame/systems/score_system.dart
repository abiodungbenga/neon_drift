import '../../../../core/constants/game_constants.dart';

class ScoreSystem {
  int currentScore = 0;
  int multiplier = 1;
  int crystalsCollected = 0;
  double _scoreAccumulator = 0.0;

  void update(double dt, double currentSpeed) {
    // Accumulate distance score over time
    _scoreAccumulator += (currentSpeed * dt * 0.1) * multiplier;
    currentScore += _scoreAccumulator.floor();
    _scoreAccumulator -= _scoreAccumulator.floor();
  }

  void addCrystalBonus() {
    crystalsCollected++;
    currentScore += GameConstants.crystalScoreValue * multiplier;
  }

  void addObstacleDodgedBonus() {
    currentScore += GameConstants.obstacleDodgedScoreValue * multiplier;
  }

  void reset() {
    currentScore = 0;
    multiplier = 1;
    crystalsCollected = 0;
    _scoreAccumulator = 0.0;
  }
}
