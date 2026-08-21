import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle titleLarge = GoogleFonts.orbitron(
    fontSize: 36.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 2.0,
    shadows: [
      Shadow(color: AppColors.neonCyan.withOpacity(0.8), blurRadius: 15),
      Shadow(color: AppColors.neonPurple.withOpacity(0.5), blurRadius: 30),
    ],
  );

  static TextStyle titleMedium = GoogleFonts.orbitron(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: AppColors.neonCyan,
    letterSpacing: 1.5,
    shadows: [
      Shadow(color: AppColors.neonCyan.withOpacity(0.6), blurRadius: 10),
    ],
  );

  static TextStyle headline = GoogleFonts.orbitron(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1.2,
  );

  static TextStyle body = GoogleFonts.rajdhani(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.8,
  );

  static TextStyle bodyBold = GoogleFonts.rajdhani(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0.8,
  );

  static TextStyle hudValue = GoogleFonts.orbitron(
    fontSize: 22.0,
    fontWeight: FontWeight.w800,
    color: AppColors.neonCyan,
    shadows: [
      Shadow(color: AppColors.neonCyan, blurRadius: 8),
    ],
  );

  static TextStyle hudLabel = GoogleFonts.rajdhani(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textMuted,
    letterSpacing: 1.5,
  );
}
