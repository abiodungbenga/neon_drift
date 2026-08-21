import 'dart:math' as math;
import 'package:flame/components.dart';
import '../../../../shared/models/powerup_type.dart';
import '../components/collectibles/energy_crystal.dart';
import '../components/enemies/drone.dart';
import '../components/obstacles/barrier.dart';
import '../components/obstacles/laser_gate.dart';
import '../components/obstacles/road_block.dart';
import '../components/powerups/powerup_component.dart';

class SpawnSystem {
  final Vector2 gameSize;
  final World world;
  final double Function() getWorldSpeed;
  final double Function() getSpawnInterval;
  final Vector2 Function() getPlayerPosition;
  final bool Function() isMagnetActive;

  double _obstacleTimer = 0.0;
  double _crystalTimer = 0.0;
  double _powerupTimer = 0.0;
  final math.Random _random = math.Random();

  SpawnSystem({
    required this.gameSize,
    required this.world,
    required this.getWorldSpeed,
    required this.getSpawnInterval,
    required this.getPlayerPosition,
    required this.isMagnetActive,
  });

  void update(double dt) {
    _obstacleTimer += dt;
    _crystalTimer += dt;
    _powerupTimer += dt;

    final speed = getWorldSpeed();

    // 1. Spawn Obstacles or Drones
    if (_obstacleTimer >= getSpawnInterval()) {
      _obstacleTimer = 0.0;
      _spawnRandomHazard(speed);
    }

    // 2. Spawn Energy Crystals
    if (_crystalTimer >= 1.2) {
      _crystalTimer = 0.0;
      _spawnCrystal(speed);
    }

    // 3. Spawn Power-ups
    if (_powerupTimer >= 12.0) {
      _powerupTimer = 0.0;
      _spawnPowerup(speed);
    }
  }

  double _getRandomLaneX() {
    // 5 lanes across play area
    final lanes = 5;
    final padding = gameSize.x * 0.15;
    final playableWidth = gameSize.x - (padding * 2);
    final laneIndex = _random.nextInt(lanes);
    return padding + (playableWidth / (lanes - 1)) * laneIndex;
  }

  void _spawnRandomHazard(double speed) {
    final x = _getRandomLaneX();
    final spawnPos = Vector2(x, -60.0);
    final hazardType = _random.nextInt(4);

    switch (hazardType) {
      case 0:
        world.add(EnergyBarrier(
          position: spawnPos,
          size: Vector2(100.0, 24.0),
          moveSpeed: speed,
        ));
        break;
      case 1:
        world.add(LaserGate(
          position: spawnPos,
          size: Vector2(gameSize.x * 0.75, 24.0),
          moveSpeed: speed,
        ));
        break;
      case 2:
        world.add(RoadBlock(
          position: spawnPos,
          size: Vector2(70.0, 40.0),
          moveSpeed: speed,
        ));
        break;
      case 3:
        world.add(EnemyDrone(
          position: spawnPos,
          moveSpeed: speed,
        ));
        break;
    }
  }

  void _spawnCrystal(double speed) {
    final x = _getRandomLaneX();
    world.add(EnergyCrystal(
      position: Vector2(x, -40.0),
      moveSpeed: speed,
      getPlayerPosition: getPlayerPosition,
      isMagnetActive: isMagnetActive,
    ));
  }

  void _spawnPowerup(double speed) {
    final x = _getRandomLaneX();
    final typeIndex = _random.nextInt(PowerUpType.values.length);
    world.add(PowerUpComponent(
      position: Vector2(x, -40.0),
      type: PowerUpType.values[typeIndex],
      moveSpeed: speed,
    ));
  }

  void reset() {
    _obstacleTimer = 0.0;
    _crystalTimer = 0.0;
    _powerupTimer = 0.0;
  }
}
