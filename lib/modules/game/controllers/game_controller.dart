import 'package:get/get.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../shared/models/game_stats.dart';
import '../../../shared/models/powerup_type.dart';
import '../flame/neon_drift_game.dart';

class GameController extends GetxController implements NeonDriftGameBridge {
  final StorageService storage = Get.find<StorageService>();
  final AudioService audio = Get.find<AudioService>();

  late NeonDriftGame flameGame;

  // Reactive HUD State
  final score = 0.obs;
  final highScore = 0.obs;
  final distanceMeters = 0.0.obs;
  final health = 100.0.obs;
  final energy = 100.0.obs;

  // Active Powerup
  final Rxn<PowerUpType> activePowerUp = Rxn<PowerUpType>();
  final powerUpRemaining = 0.0.obs;

  // Overlays State
  final isPaused = false.obs;
  final isGameOver = false.obs;
  final Rxn<GameStats> gameStats = Rxn<GameStats>();

  @override
  void onInit() {
    super.onInit();
    highScore.value = storage.highScore;
    flameGame = NeonDriftGame(bridge: this);
  }

  @override
  void onScoreUpdated(int currentScore, double currentDistance) {
    score.value = currentScore;
    distanceMeters.value = currentDistance;
  }

  @override
  void onHealthUpdated(double currentHealth, double maxHealth) {
    health.value = currentHealth;
  }

  @override
  void onEnergyUpdated(double currentEnergy, double maxEnergy) {
    energy.value = currentEnergy;
  }

  @override
  void onPowerUpActivated(PowerUpType? type, double remainingDuration) {
    activePowerUp.value = type;
    powerUpRemaining.value = remainingDuration;
  }

  @override
  void onGameOver(int finalScore, double distanceMeters, int crystalsCollected) {
    isGameOver.value = true;
    final isNewHigh = finalScore > highScore.value;

    if (isNewHigh) {
      storage.saveHighScore(finalScore);
      highScore.value = finalScore;
      audio.playHighScore();
    } else {
      audio.playGameOver();
    }

    storage.incrementTotalGames();

    gameStats.value = GameStats(
      finalScore: finalScore,
      highScore: highScore.value,
      crystalsCollected: crystalsCollected,
      distanceMeters: distanceMeters,
      survivalTimeSeconds: flameGame.difficultySystem.elapsedTime,
      isNewHighScore: isNewHigh,
    );
  }

  @override
  void playSfx(String soundName) {
    audio.playSfx(soundName);
  }

  void togglePause() {
    if (isGameOver.value) return;
    isPaused.value = !isPaused.value;

    if (isPaused.value) {
      flameGame.pauseEngine();
    } else {
      flameGame.resumeEngine();
    }
  }

  void restartGame() {
    isPaused.value = false;
    isGameOver.value = false;
    gameStats.value = null;
    flameGame.restartGame();
  }

  void exitToMenu() {
    Get.offAllNamed('/home');
  }
}
