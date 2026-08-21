class GameStats {
  final int finalScore;
  final int highScore;
  final int crystalsCollected;
  final double distanceMeters;
  final double survivalTimeSeconds;
  final bool isNewHighScore;

  GameStats({
    required this.finalScore,
    required this.highScore,
    required this.crystalsCollected,
    required this.distanceMeters,
    required this.survivalTimeSeconds,
    required this.isNewHighScore,
  });
}
