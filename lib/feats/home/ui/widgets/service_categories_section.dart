import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/feats/home/models/service_category.dart';
import 'home_section_header.dart';
import 'home_styles.dart';

class ServiceCategoriesSection extends StatelessWidget {
  const ServiceCategoriesSection({
    super.key,
    this.categories = ServiceCategory.defaults,
    this.onSeeAll,
    this.onCategoryTap,
  });

  final List<ServiceCategory> categories;
  final VoidCallback? onSeeAll;
  final ValueChanged<ServiceCategory>? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          HomeSectionHeader(title: 'التصنيفات', onSeeAll: onSeeAll),
          SizedBox(height: 14.h),
          Row(
            children: [
              for (final category in categories)
                Expanded(
                  child: _CategoryItem(
                    category: category,
                    onTap: onCategoryTap == null
                        ? null
                        : () => onCategoryTap!(category),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({required this.category, this.onTap});

  final ServiceCategory category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20.r);

    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
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
              child: Icon(category.icon, size: 28.sp, color: AppColors.primary),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          category.label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: HomeStyles.titleColor,
          ),
        ),
      ],
    );
  }
}
