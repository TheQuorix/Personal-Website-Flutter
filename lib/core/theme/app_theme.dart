import 'package:flutter/material.dart';
import 'package:personal_website/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get main {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'VCROSDMono',
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const BeveledRectangleBorder(),
          side: const BorderSide(color: AppColors.border, width: 2),
          foregroundColor: AppColors.textPrimary,
        ),
      ),
    );
  }
}
