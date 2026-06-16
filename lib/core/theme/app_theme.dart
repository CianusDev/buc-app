import 'package:flutter/material.dart';
import 'package:tuto_flutter/core/constants/app_colors.dart';
import 'package:tuto_flutter/core/constants/app_sizes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    fontFamily: 'GeneralSans',
    scaffoldBackgroundColor: AppColors.secondary,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.foreground,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.raduis),
        ),
      ),
    ),
  );
}
