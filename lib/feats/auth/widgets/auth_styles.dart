import 'package:flutter/material.dart';
import 'package:shatab/core/utils/responsive_extension.dart';

class AuthStyles {
  AuthStyles._();

  static const Color titleColor = Color(0xFF0F1D4D);
  static const Color bodyColor = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFE2E8F5);
  static const Color errorColor = Color(0xFFE5484D);
  static const Color iconColor = Color(0xFF7B849A);

  static TextStyle get title => TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w800,
    color: titleColor,
    height: 1.3,
  );

  static TextStyle get subtitle =>
      TextStyle(fontSize: 15.sp, color: bodyColor, height: 1.5);

  static TextStyle get input => TextStyle(
    fontSize: 15.sp,
    color: titleColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get hint => TextStyle(fontSize: 15.sp, color: bodyColor);

  static TextStyle get error =>
      TextStyle(fontSize: 12.sp, color: errorColor, height: 1.4);

  static TextStyle get body => TextStyle(fontSize: 14.sp, color: bodyColor);
}
