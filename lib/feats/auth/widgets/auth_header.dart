import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'auth_styles.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final canGoBack = onBack != null || Navigator.of(context).canPop();

    return Column(
      children: [
        SizedBox(
          height: 48.h,
          child: Align(
            alignment: Alignment.centerLeft,
            child: canGoBack
                ? IconButton(
                    onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                    icon: Icon(
                      SolarIconsOutline.altArrowLeft,
                      size: 24.sp,
                      color: AuthStyles.titleColor,
                    ),
                  )
                : null,
          ),
        ),
        SizedBox(height: 32.h),
        Text(title, textAlign: TextAlign.center, style: AuthStyles.title),
        SizedBox(height: 10.h),
        Text(subtitle, textAlign: TextAlign.center, style: AuthStyles.subtitle),
      ],
    );
  }
}
