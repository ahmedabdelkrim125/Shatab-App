import 'package:flutter/material.dart';
import 'package:shatab/core/const/images_app.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:solar_icons/solar_icons.dart';
import 'home_section_header.dart';
import 'home_styles.dart';

class StartProjectSection extends StatelessWidget {
  const StartProjectSection({
    super.key,
    this.onFullFinishing,
    this.onSingleService,
  });

  final VoidCallback? onFullFinishing;
  final VoidCallback? onSingleService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const HomeSectionHeader(title: 'كيف تحب تبدأ؟', showSeeAll: false),
          SizedBox(height: 14.h),
          _FullFinishingCard(onTap: onFullFinishing),
          SizedBox(height: 12.h),
          _SingleServiceCard(onTap: onSingleService),
        ],
      ),
    );
  }
}

class _FullFinishingCard extends StatelessWidget {
  const _FullFinishingCard({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(24.r);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: HomeStyles.titleColor.withValues(alpha: 0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImagesApp.finishingBackground,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.centerStart,
                    end: AlignmentDirectional.centerEnd,
                    colors: [
                      Colors.white.withValues(alpha: 0.88),
                      Colors.white.withValues(alpha: 0.62),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                borderRadius: radius,
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'تشطيب شقتك بالكامل',
                              style: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w800,
                                color: HomeStyles.titleColor,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'اطلب عروض أسعار من شركات ومهندسين ينفذون شقتك من أول التأسيس لآخر لمسة',
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                color: HomeStyles.titleColor.withValues(
                                  alpha: 0.75,
                                ),
                                height: 1.6,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'ابدأ طلب التشطيب',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    SolarIconsOutline.arrowRight,
                                    size: 16.sp,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(flex: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SingleServiceCard extends StatelessWidget {
  const _SingleServiceCard({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(22.r);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: HomeStyles.softShadow,
      ),
      child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: const BorderSide(color: HomeStyles.borderColor),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 52.w,
                  height: 52.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    SolarIconsOutline.clipboardAdd,
                    size: 26.sp,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تحتاج خدمة محددة فقط؟',
                        style: HomeStyles.cardTitle,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'سباك أو نجار أو كهربائي، اطلب الفني الذي ينقصك',
                        style: HomeStyles.body,
                      ),
                    ],
                  ),
                ),
                Icon(
                  SolarIconsOutline.altArrowLeft,
                  size: 20.sp,
                  color: HomeStyles.iconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
