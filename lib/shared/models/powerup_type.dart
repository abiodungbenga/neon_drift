import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

enum PowerUpType {
  shield,
  magnet,
  boost,
}

extension PowerUpTypeExtension on PowerUpType {
  String get title {
    switch (this) {
      case PowerUpType.shield:
        return 'CYBER SHIELD';
      case PowerUpType.magnet:
        return 'CRYSTAL MAGNET';
      case PowerUpType.boost:
        return 'HYPER BOOST';
    }
  }

  String get description {
    switch (this) {
      case PowerUpType.shield:
        return 'Protects vehicle from one obstacle or drone collision';
      case PowerUpType.magnet:
        return 'Automatically attracts nearby energy crystals';
      case PowerUpType.boost:
        return 'Triggers maximum speed, score multiplier & temporary invincibility';
    }
  }

  Color get color {
    switch (this) {
      case PowerUpType.shield:
        return AppColors.neonCyan;
      case PowerUpType.magnet:
        return AppColors.neonPurple;
      case PowerUpType.boost:
        return AppColors.neonGold;
    }
  }

  IconData get icon {
    switch (this) {
      case PowerUpType.shield:
        return Icons.security_rounded;
      case PowerUpType.magnet:
        return Icons.radar_rounded;
      case PowerUpType.boost:
        return Icons.speed_rounded;
    }
  }
}
