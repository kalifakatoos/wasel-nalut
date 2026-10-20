// design_system.dart — Wasel Nalut World-Class Design System Tokens
import 'package:flutter/material.dart';

class AppColors {
  // Brand Primaries (Modern Super-App Palette)
  static const Color waselPrimary   = Color(0xFFE23744); // Crimson Red
  static const Color waselSecondary = Color(0xFFFF6600); // Sunset Orange
  static const Color waselPurple    = Color(0xFF8B5CF6); // Royal Violet
  static const Color waselGreen     = Color(0xFF10B981); // Emerald Green
  static const Color waselLight     = Color(0xFFFFECEE); // Soft Red Accent
  static const Color gold           = Color(0xFFFFB800); // Rating Gold

  // Neutrals (Dark Super-App Mode)
  static const Color darkBackground     = Color(0xFF070A12);
  static const Color darkSurface        = Color(0xFF0F172A);
  static const Color darkCard           = Color(0xFF1E293B);
  static const Color darkBorder         = Color(0xFF334155);
  static const Color darkTextPrimary    = Color(0xFFF8FAFC);
  static const Color darkTextSecondary  = Color(0xFF94A3B8);
  static const Color darkTextMuted      = Color(0xFF64748B);

  // Glassmorphism & Effects
  static Color glassBackground = const Color(0xFF1E293B).withOpacity(0.75);
  static Color glassBorder     = const Color(0xFF475569).withOpacity(0.3);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error   = Color(0xFFEF4444);
  static const Color info    = Color(0xFF3B82F6);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.waselPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.waselPrimary,
      secondary: AppColors.waselSecondary,
      surface: AppColors.darkSurface,
      error: AppColors.error,
    ),
    fontFamily: 'Tajawal',
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
