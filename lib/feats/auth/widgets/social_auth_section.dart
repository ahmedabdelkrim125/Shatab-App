import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'auth_styles.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({super.key, this.onGoogle, this.onApple});

  final VoidCallback? onGoogle;
  final VoidCallback? onApple;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AuthStyles.borderColor)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Text('أو تابع باستخدام', style: AuthStyles.body),
            ),
            const Expanded(child: Divider(color: AuthStyles.borderColor)),
          ],
        ),
        SizedBox(height: 18.h),
        Row(
          children: [
            Expanded(
              child: _SocialButton(
                onTap: onApple,
                child: Icon(Icons.apple, size: 28.sp, color: Colors.black),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: _SocialButton(
                onTap: onGoogle,
                child: Text(
                  'G',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF4285F4),
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16.r);

    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: const BorderSide(color: AuthStyles.borderColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: SizedBox(
          height: 54.h,
          child: Center(child: child),
        ),
      ),
    );
  }
}
