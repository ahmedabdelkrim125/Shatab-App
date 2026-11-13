import 'package:flutter/material.dart';
import 'package:shatab/core/utils/responsive_extension.dart';

class HomeStyles {
  HomeStyles._();

  static const Color titleColor = Color(0xFF0F1D4D);
  static const Color bodyColor = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFE2E8F5);
  static const Color iconColor = Color(0xFF7B849A);
  static const Color starColor = Color(0xFFF5A524);

  static TextStyle get sectionTitle => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w800,
    color: titleColor,
  );

  static TextStyle get cardTitle => TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w800,
    color: titleColor,
  );

  static TextStyle get body =>
      TextStyle(fontSize: 12.5.sp, color: bodyColor, height: 1.5);

  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: titleColor.withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}
