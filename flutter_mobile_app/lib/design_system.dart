// design_system.dart — Wasel Nalut Design Tokens & Color Palette
import 'package:flutter/material.dart';

class AppColors {
  // Wasel Brand Primaries
  static const Color waselPrimary   = Color(0xFFE23744); // Presto Crimson Red
  static const Color waselSecondary = Color(0xFFFF6600); // Sunset Orange
  static const Color waselPurple    = Color(0xFF7C3AED); // Mataa Royal Violet
  static const Color waselGreen     = Color(0xFF10B981); // Jet Express Emerald
  static const Color waselLight     = Color(0xFFFFECEE); // Soft Red Accent
  static const Color gold           = Color(0xFFFFB800); // Star Rating & Badges

  // Neutrals (Light Mode)
  static const Color lightBackground     = Color(0xFFF8FAFC);
  static const Color lightSurface        = Color(0xFFFFFFFF);
  static const Color lightCard           = Color(0xFFFFFFFF);
  static const Color lightBorder         = Color(0xFFE2E8F0);
  static const Color lightTextPrimary    = Color(0xFF0F172A);
  static const Color lightTextSecondary  = Color(0xFF475569);
  static const Color lightTextMuted      = Color(0xFF94A3B8);

  // Neutrals (Dark Mode)
  static const Color darkBackground      = Color(0xFF0B0F19);
  static const Color darkSurface         = Color(0xFF131B2E);
  static const Color darkCard            = Color(0xFF1E293B);
  static const Color darkBorder          = Color(0xFF334155);
  static const Color darkTextPrimary     = Color(0xFFF8FAFC);
  static const Color darkTextSecondary   = Color(0xFF94A3B8);
  static const Color darkTextMuted       = Color(0xFF64748B);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error   = Color(0xFFEF4444);
  static const Color info    = Color(0xFF3B82F6);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.waselPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.waselPrimary,
      secondary: AppColors.waselSecondary,
      surface: AppColors.lightSurface,
      error: AppColors.error,
    ),
    fontFamily: 'Tajawal',
  );

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
  );
}
