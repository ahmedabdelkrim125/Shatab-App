import 'package:flutter/material.dart';
import 'package:shatab/core/const/images_app.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:solar_icons/solar_icons.dart';
import 'home_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.onSearch,
    this.onFilterTap,
    this.onNotificationsTap,
  });

  final ValueChanged<String>? onSearch;
  final VoidCallback? onFilterTap;
  final VoidCallback? onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(28.r)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(ImagesApp.modernVilla, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HomeStyles.titleColor.withValues(alpha: 0.3),
                  HomeStyles.titleColor.withValues(alpha: 0.85),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مرحبًا بك في شطب',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'ابحث عن مقدم خدمة\nلشقتك',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: onNotificationsTap,
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                        child: Icon(
                          SolarIconsOutline.bell,
                          size: 22.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                _SearchBar(onSearch: onSearch, onFilterTap: onFilterTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({this.onSearch, this.onFilterTap});

  final ValueChanged<String>? onSearch;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      padding: EdgeInsetsDirectional.only(start: 18.w, end: 7.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            SolarIconsOutline.magnifier,
            size: 22.sp,
            color: HomeStyles.iconColor,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              onSubmitted: onSearch,
              textInputAction: TextInputAction.search,
              cursorColor: AppColors.primary,
              style: TextStyle(
                fontSize: 14.sp,
                color: HomeStyles.titleColor,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration.collapsed(
                hintText: 'ابحث عن مهندس أو فني أو شركة',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: HomeStyles.bodyColor,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: Icon(
                SolarIconsOutline.tuning,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
