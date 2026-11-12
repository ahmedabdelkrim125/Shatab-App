import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';

import '../../auth/widgets/auth_styles.dart';
import 'main_tab.dart';

class TabPlaceholder extends StatelessWidget {
  const TabPlaceholder({super.key, required this.tab});

  final MainTab tab;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88.w,
            height: 88.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(tab.activeIcon, size: 40.sp, color: AppColors.primary),
          ),
          SizedBox(height: 20.h),
          Text(tab.label, style: AuthStyles.title.copyWith(fontSize: 24.sp)),
          SizedBox(height: 8.h),
          Text('هذه الصفحة قيد التجهيز', style: AuthStyles.subtitle),
        ],
      ),
    );
  }
}
