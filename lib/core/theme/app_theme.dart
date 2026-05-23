import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF1A367C);
  static const Color priceBlue = Color(0xFF1A367C);
  static const Color deleteRed = Color(0xFFD32F2F);
  static const Color scaffoldBg = Color(0xFFF5F5F5);
  static const Color cardWhite = Colors.white;
  static const Color inputBg = Color(0xFFEDEDED);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textMuted = Color(0xFF757575);
  static const Color textLight = Color(0xFF9E9E9E);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color infoBg = Color(0xFFE8EEF7);
  static const Color skeleton = Color(0xFFE0E0E0);
  static const Color accentBlue = Color(0xFF3D5AFE);
  static const Color loadingHalo = Color(0xFFB3C5F7);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryNavy,
        primary: AppColors.primaryNavy,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.scaffoldBg,
        foregroundColor: AppColors.primaryNavy,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.primaryNavy,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryNavy),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      fontFamily: 'Roboto',
    );
  }
}
