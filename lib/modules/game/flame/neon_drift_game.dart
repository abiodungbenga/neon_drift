import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/models/powerup_type.dart';
import 'components/collectibles/energy_crystal.dart';
import 'components/effects/particle_system.dart';
import 'components/effects/screen_shake.dart';
import 'components/enemies/drone.dart';
import 'components/obstacles/barrier.dart';
import 'components/obstacles/laser_gate.dart';
import 'components/obstacles/road_block.dart';
import 'components/player/hover_vehicle.dart';
import 'components/player/motion_trail.dart';
import 'components/powerups/powerup_component.dart';
import 'systems/difficulty_system.dart';
import 'systems/score_system.dart';
import 'systems/spawn_system.dart';
import 'world/neon_grid_background.dart';

abstract class NeonDriftGameBridge {
  void onScoreUpdated(int score, double distanceMeters);
  void onHealthUpdated(double currentHealth, double maxHealth);
  void onEnergyUpdated(double currentEnergy, double maxEnergy);
  void onPowerUpActivated(PowerUpType? type, double remainingDuration);
  void onGameOver(int finalScore, double distanceMeters, int crystalsCollected);
  void playSfx(String soundName);
}

class NeonDriftGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, DragCallbacks {
  final NeonDriftGameBridge bridge;

  late HoverVehicle player;
  late NeonGridBackground gridBg;
  late DifficultySystem difficultySystem;
  late ScoreSystem scoreSystem;
  late SpawnSystem spawnSystem;

  // Real-time Gameplay Stats
  double health = 100.0;
  double energy = 100.0;
  bool isGameOver = false;

  // Active Power-ups
  PowerUpType? activePowerUp;
  double powerUpTimer = 0.0;

  // Keyboard Movement Flags
  bool _isMovingLeft = false;
  bool _isMovingRight = false;
  bool _isMovingUp = false;
  bool _isMovingDown = false;

  NeonDriftGame({required this.bridge});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 1. Systems Initialization
    difficultySystem = DifficultySystem();
    scoreSystem = ScoreSystem();

    // 2. Background Grid
    gridBg = NeonGridBackground(
      gameSize: size,
      getWorldSpeed: () => difficultySystem.currentSpeed,
    );
    world.add(gridBg);

    // 3. Player Hover Vehicle
    player = HoverVehicle(gameSize: size);
    world.add(player);

    // 4. Motion Trail
    world.add(MotionTrail(
      getPlayerPosition: () => player.position,
      isBoosted: () => activePowerUp == PowerUpType.boost,
    ));

    // 5. Spawner System
    spawnSystem = SpawnSystem(
      gameSize: size,
      world: world,
      getWorldSpeed: () => difficultySystem.currentSpeed,
      getSpawnInterval: () => difficultySystem.obstacleSpawnInterval,
      getPlayerPosition: () => player.position,
      isMagnetActive: () => activePowerUp == PowerUpType.magnet,
    );
  }

  @override
  void update(double dt) {
    if (isGameOver) return;
    super.update(dt);

    // 1. Process Keyboard Directional Velocity
    _updateKeyboardMovement();

    // 2. Update Systems
    difficultySystem.update(dt);
    scoreSystem.update(dt, difficultySystem.currentSpeed);
    spawnSystem.update(dt);

    // 3. Energy Decay
    energy -= 2.5 * dt;
    if (energy <= 0) {
      energy = 0;
      _triggerGameOver();
      return;
    }

    // 4. Power-Up Durations
    if (activePowerUp != null) {
      powerUpTimer -= dt;
      if (powerUpTimer <= 0) {
        _deactivatePowerUp();
      } else {
        bridge.onPowerUpActivated(activePowerUp, powerUpTimer);
      }
    }

    // 5. Bridge HUD Sync
    bridge.onScoreUpdated(scoreSystem.currentScore, difficultySystem.distanceMeters);
    bridge.onHealthUpdated(health, 100.0);
    bridge.onEnergyUpdated(energy, 100.0);

    // 6. Check Collisions between Player and World Entities
    _checkCustomCollisions();
  }

  void _updateKeyboardMovement() {
    double vx = 0;
    double vy = 0;

    if (_isMovingLeft) vx -= 1.0;
    if (_isMovingRight) vx += 1.0;
    if (_isMovingUp) vy -= 1.0;
    if (_isMovingDown) vy += 1.0;

    player.velocity = Vector2(vx, vy);
  }

  void _checkCustomCollisions() {
    final playerRect = Rect.fromLTWH(
      player.position.x - player.size.x / 2,
      player.position.y - player.size.y / 2,
      player.size.x,
      player.size.y,
    );

    for (final child in world.children.toList()) {
      if (child is PositionComponent && child != player) {
        final childRect = Rect.fromLTWH(
          child.position.x - child.size.x / 2,
          child.position.y - child.size.y / 2,
          child.size.x,
          child.size.y,
        );

        if (playerRect.overlaps(childRect)) {
          if (child is EnergyCrystal) {
            _onCollectCrystal(child);
          } else if (child is PowerUpComponent) {
            _onCollectPowerUp(child);
          } else if (child is EnergyBarrier || child is LaserGate || child is RoadBlock || child is EnemyDrone) {
            _onCollideHazard(child);
          }
        }
      }
    }
  }

  void _onCollectCrystal(EnergyCrystal crystal) {
    crystal.removeFromParent();
    scoreSystem.addCrystalBonus();
    energy = (energy + 15.0).clamp(0.0, 100.0);
    world.add(ParticleSystem.createCrystalSparkles(position: crystal.position));
    bridge.playSfx('crystal');
  }

  void _onCollectPowerUp(PowerUpComponent powerup) {
    powerup.removeFromParent();
    _activatePowerUp(powerup.type);
    bridge.playSfx('powerup');
  }

  void _activatePowerUp(PowerUpType type) {
    activePowerUp = type;
    switch (type) {
      case PowerUpType.shield:
        powerUpTimer = 8.0;
        player.isShielded = true;
        break;
      case PowerUpType.magnet:
        powerUpTimer = 7.0;
        break;
      case PowerUpType.boost:
        powerUpTimer = 5.0;
        player.isBoosted = true;
        scoreSystem.multiplier = 2;
        break;
    }
    bridge.onPowerUpActivated(type, powerUpTimer);
  }

  void _deactivatePowerUp() {
    activePowerUp = null;
    powerUpTimer = 0.0;
    player.isShielded = false;
    player.isBoosted = false;
    scoreSystem.multiplier = 1;
    bridge.onPowerUpActivated(null, 0);
  }

  void _onCollideHazard(PositionComponent hazard) {
    if (activePowerUp == PowerUpType.boost) return; // Invincible during hyper boost

    if (player.isShielded) {
      // Shield absorbs hit
      hazard.removeFromParent();
      _deactivatePowerUp();
      world.add(ParticleSystem.createExplosion(position: player.position));
      bridge.playSfx('collision');
      return;
    }

    hazard.removeFromParent();
    health -= 25.0;
    player.triggerHitEffect();
    world.add(ScreenShake(camera: camera));
    world.add(ParticleSystem.createExplosion(position: player.position));
    bridge.playSfx('collision');

    if (health <= 0) {
      health = 0;
      _triggerGameOver();
    }
  }

  void _triggerGameOver() {
    isGameOver = true;
    pauseEngine();
    bridge.onGameOver(
      scoreSystem.currentScore,
      difficultySystem.distanceMeters,
      scoreSystem.crystalsCollected,
    );
  }

  void restartGame() {
    health = 100.0;
    energy = 100.0;
    isGameOver = false;
    _deactivatePowerUp();

    difficultySystem.reset();
    scoreSystem.reset();
    spawnSystem.reset();

    // Clear world hazards and collectibles
    for (final child in world.children.toList()) {
      if (child is EnergyBarrier ||
          child is LaserGate ||
          child is RoadBlock ||
          child is EnemyDrone ||
          child is EnergyCrystal ||
          child is PowerUpComponent) {
        child.removeFromParent();
      }
    }

    player.position = Vector2(size.x / 2, size.y * 0.82);
    player.velocity = Vector2.zero();

    resumeEngine();
  }

  // Keyboard Event Handlers
  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _isMovingLeft = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    _isMovingRight = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    _isMovingUp = keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);
    _isMovingDown = keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown);

    return KeyEventResult.handled;
  }

  // Touch Drag Event Handlers
  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (isGameOver) return;
    player.position += event.localDelta;
  }
}
