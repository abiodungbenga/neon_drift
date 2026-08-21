class GameConstants {
  // Player Settings
  static const double basePlayerSpeed = 350.0;
  static const double maxPlayerHealth = 100.0;
  static const double maxPlayerEnergy = 100.0;
  static const double energyDecayRate = 2.5; // per second
  static const double crystalEnergyRestore = 15.0;

  // Initial Game Speed & Difficulty
  static const double initialWorldSpeed = 220.0;
  static const double maxWorldSpeed = 650.0;
  static const double speedIncreaseRate = 3.5; // per second

  // Spawns
  static const double baseObstacleSpawnInterval = 1.8;
  static const double minObstacleSpawnInterval = 0.6;
  static const double baseCrystalSpawnInterval = 1.2;
  static const double basePowerupSpawnInterval = 10.0;

  // PowerUp Durations (seconds)
  static const double shieldDuration = 8.0;
  static const double magnetDuration = 7.0;
  static const double boostDuration = 5.0;

  // Magnetic Radius
  static const double magnetRadius = 220.0;

  // Scores
  static const int crystalScoreValue = 50;
  static const int obstacleDodgedScoreValue = 20;

  // Storage Keys
  static const String keyHighScore = 'nd_high_score';
  static const String keySfxEnabled = 'nd_sfx_enabled';
  static const String keyMusicEnabled = 'nd_music_enabled';
  static const String keyTotalGames = 'nd_total_games';
}
