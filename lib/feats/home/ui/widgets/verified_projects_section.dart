import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import '../../../../core/utils/responsive_extension.dart';
import '../../models/verified_project.dart';
import 'package:solar_icons/solar_icons.dart';
import 'home_section_header.dart';
import 'home_styles.dart';

class VerifiedProjectsSection extends StatelessWidget {
  const VerifiedProjectsSection({
    super.key,
    this.projects = VerifiedProject.samples,
    this.onSeeAll,
    this.onProjectTap,
  });

  final List<VerifiedProject> projects;
  final VoidCallback? onSeeAll;
  final ValueChanged<VerifiedProject>? onProjectTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: HomeSectionHeader(
            title: 'مشاريع موثقة من عملاء حقيقيين',
            onSeeAll: onSeeAll,
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          height: 270.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: projects.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final project = projects[index];
              return _ProjectCard(
                project: project,
                onTap: onProjectTap == null
                    ? null
                    : () => onProjectTap!(project),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, this.onTap});

  final VerifiedProject project;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(22.r);

    return SizedBox(
      width: 262.w,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: HomeStyles.softShadow,
        ),
        child: Material(
          color: AppColors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: const BorderSide(color: HomeStyles.borderColor),
          ),
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 124.h,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(project.imagePath, fit: BoxFit.cover),
                      PositionedDirectional(
                        top: 10.h,
                        start: 10.w,
                        child: const _VerifiedBadge(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: HomeStyles.cardTitle.copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${project.district} • ${project.area} م²',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: HomeStyles.body.copyWith(fontSize: 12.sp),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            _InfoChip(
                              icon: SolarIconsOutline.paintRoller,
                              label: project.finishingType,
                            ),
                            SizedBox(width: 6.w),
                            _InfoChip(
                              icon: SolarIconsOutline.checkCircle,
                              label: project.duration,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 24.w,
                              height: 24.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary.withValues(alpha: 0.1),
                              ),
                              child: Text(
                                project.providerName
                                    .replaceFirst(RegExp(r'^م\.\s*'), '')
                                    .characters
                                    .first,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                project.providerName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: HomeStyles.titleColor,
                                ),
                              ),
                            ),
                            if (project.costRange != null) ...[
                              SizedBox(width: 6.w),
                              Text(
                                project.costRange!,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.success,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(SolarIconsBold.verifiedCheck, size: 13.sp, color: Colors.white),
          SizedBox(width: 4.w),
          Text(
            'تم تأكيده من العميل',
            style: TextStyle(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: AppColors.primary),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: HomeStyles.titleColor,
            ),
          ),
        ],
      ),
    );
  }
}
