import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:solar_icons/solar_icons.dart';
import 'home_section_header.dart';
import 'home_styles.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  static const List<_Step> _steps = [
    _Step(
      icon: SolarIconsOutline.clipboardAdd,
      title: 'اطلب',
      description: 'صف شقتك وميزانيتك',
    ),
    _Step(
      icon: SolarIconsOutline.usersGroupRounded,
      title: 'قارن',
      description: 'استلم العروض وقارن بينها',
    ),
    _Step(
      icon: SolarIconsOutline.checkCircle,
      title: 'نفّذ',
      description: 'اختر وابدأ التنفيذ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const HomeSectionHeader(title: 'كيف يعمل شطب؟', showSeeAll: false),
          SizedBox(height: 14.h),
          // IntrinsicHeight: بيحسب أطول كارت ويوحّد ارتفاع الباقي
          // من غير ما الـ Row ياخد ارتفاع لانهائي جوه الـ ScrollView.
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < _steps.length; i++) ...[
                  if (i > 0) SizedBox(width: 10.w),
                  Expanded(
                    child: _StepCard(step: _steps[i], number: i + 1),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Step {
  const _Step({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step, required this.number});

  final _Step step;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: HomeStyles.borderColor),
        boxShadow: HomeStyles.softShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.1),
                ),
                child: Icon(step.icon, size: 24.sp, color: AppColors.primary),
              ),
              PositionedDirectional(
                top: -2.h,
                end: -4.w,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Text(
                    '$number',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: HomeStyles.cardTitle.copyWith(fontSize: 14.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            step.description,
            textAlign: TextAlign.center,
            style: HomeStyles.body.copyWith(fontSize: 11.5.sp),
          ),
        ],
      ),
    );
  }
}
