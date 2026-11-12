import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'auth_styles.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key, required this.current, required this.titles});

  final int current;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الخطوة ${current + 1} من ${titles.length} · ${titles[current]}',
          style: AuthStyles.body.copyWith(
            color: AuthStyles.titleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            for (var i = 0; i < titles.length; i++) ...[
              if (i > 0) SizedBox(width: 8.w),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: i <= current
                        ? AppColors.primary
                        : AuthStyles.borderColor,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
