import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color background = Color(0xFF0A0A16);
  static const Color cardBg = Color(0xFF12122A);
  static const Color glassBg = Color(0xCC0E0E24);
  
  // Neon Accents
  static const Color neonCyan = Color(0xFF00F3FF);
  static const Color neonPink = Color(0xFFFF007F);
  static const Color neonPurple = Color(0xFF9D00FF);
  static const Color neonGold = Color(0xFFFFD700);
  static const Color neonGreen = Color(0xFF00FF88);
  static const Color neonRed = Color(0xFFFF2A55);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB3FFFFFF);
  static const Color textMuted = Color(0x66FFFFFF);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [neonCyan, neonPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [neonPink, neonGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyberBackground = LinearGradient(
    colors: [Color(0xFF070712), Color(0xFF140D2B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
