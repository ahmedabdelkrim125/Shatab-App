import 'package:flutter/material.dart';
import '../utils/responsive_extension.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF2457E8);
  static const Color primaryDark = Color(0xFF14339B);
  static const Color navy = Color(0xFF17243A);
  static const Color primaryLight = Color(0xFFA8BDD6);
  static const Color surface = Color(0xFFEAF0F7);
  static const Color background = Color(0xFFF7F9FD);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF8A94A6);
  static const Color textPrimary = navy;
  static const Color textSecondary = Color(0xFF5B6478);
  static const Color error = Color(0xFFE5484D);
  static const Color success = Color(0xFF16A34A);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [primary, primaryDark],
  );

  static const LinearGradient onboardingBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [white, background, surface],
  );
}

abstract final class AppFonts {
  static const String primary = 'IBMPlexSansArabic';
}

abstract final class AppTextStyles {
  static TextStyle get _base => TextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get heading1 =>
      _base.copyWith(fontSize: 28.sp, fontWeight: FontWeight.w700);

  static TextStyle get heading2 =>
      _base.copyWith(fontSize: 22.sp, fontWeight: FontWeight.w700);

  static TextStyle get title =>
      _base.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600);

  static TextStyle get body => _base.copyWith(fontSize: 16.sp);

  static TextStyle get bodySmall =>
      _base.copyWith(fontSize: 14.sp, color: AppColors.textSecondary);

  static TextStyle get caption =>
      _base.copyWith(fontSize: 12.sp, color: AppColors.grey);

  static TextStyle get button => _base.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle get link => _base.copyWith(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static TextStyle get onboardingTitle =>
      _base.copyWith(fontSize: 30.sp, fontWeight: FontWeight.w800, height: 1.5);

  static TextStyle get onboardingDescription => _base.copyWith(
    fontSize: 16.sp,
    color: AppColors.textSecondary,
    height: 1.8,
  );
}

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: AppFonts.primary,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      surface: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: AppColors.navy,
    ),
  );
}
