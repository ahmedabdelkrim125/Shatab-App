import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/feats/auth/models/user_role.dart';
import 'package:solar_icons/solar_icons.dart';
import 'auth_styles.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.role,
    required this.selected,
    required this.onTap,
  });

  final UserRole role;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(24.r);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: radius,
        border: Border.all(
          color: selected ? AppColors.primary : AuthStyles.borderColor,
          width: selected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (selected ? AppColors.primary : Colors.black).withValues(
              alpha: selected ? 0.18 : 0.04,
            ),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                Image.asset(
                  role.image,
                  width: 96.w,
                  height: 96.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        role.title,
                        style: AuthStyles.title.copyWith(fontSize: 19.sp),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        role.description,
                        style: AuthStyles.body.copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                selected
                    ? Icon(
                        SolarIconsOutline.checkCircle,
                        size: 26.sp,
                        color: AppColors.primary,
                      )
                    : Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AuthStyles.borderColor,
                            width: 1.5,
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
