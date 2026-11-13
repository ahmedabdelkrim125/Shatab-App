import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/feats/home/models/featured_provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'home_section_header.dart';
import 'home_styles.dart';

class FeaturedProvidersSection extends StatelessWidget {
  const FeaturedProvidersSection({
    super.key,
    this.providers = FeaturedProvider.samples,
    this.onSeeAll,
    this.onProviderTap,
  });

  final List<FeaturedProvider> providers;
  final VoidCallback? onSeeAll;
  final ValueChanged<FeaturedProvider>? onProviderTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: HomeSectionHeader(
            title: 'مقدمو خدمة مميزون',
            onSeeAll: onSeeAll,
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          height: 172.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: providers.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final provider = providers[index];
              return _ProviderCard(
                provider: provider,
                onTap: onProviderTap == null
                    ? null
                    : () => onProviderTap!(provider),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProviderCard extends StatelessWidget {
  const _ProviderCard({required this.provider, this.onTap});

  final FeaturedProvider provider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(22.r);
    final initial = provider.name.replaceFirst(RegExp(r'^م\.\s*'), '');

    return SizedBox(
      width: 150.w,
      child: Container(
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
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52.w,
                    height: 52.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.1),
                    ),
                    child: Text(
                      initial.isEmpty ? '' : initial[0],
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          provider.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: HomeStyles.cardTitle.copyWith(fontSize: 14.sp),
                        ),
                      ),
                      if (provider.verified) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          SolarIconsBold.verifiedCheck,
                          size: 16.sp,
                          color: AppColors.primary,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    provider.specialty,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: HomeStyles.body.copyWith(fontSize: 12.sp),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        SolarIconsBold.star,
                        size: 16.sp,
                        color: HomeStyles.starColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        provider.rating.toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: HomeStyles.titleColor,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '(${provider.reviewsCount})',
                        style: HomeStyles.body.copyWith(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
