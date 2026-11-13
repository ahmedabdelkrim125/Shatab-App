import 'package:flutter/material.dart';
import 'package:shatab/core/const/images_app.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/feats/home/models/promo_banner.dart';
import 'package:solar_icons/solar_icons.dart';
import 'home_styles.dart';

class PromoBannerCard extends StatelessWidget {
  const PromoBannerCard({super.key, required this.banner, this.onTap});

  final PromoBanner banner;
  final VoidCallback? onTap;

  static const double _designWidth = 358;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final s = width / _designWidth;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24 * s),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.25),
                width: 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22 * s),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    ImagesApp.bannerBackground,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    width: width * 0.5,
                    child: Image.asset(
                      ImagesApp.livingRoom,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                  Positioned(
                    left: width * 0.19,
                    right: width * 0.5,
                    top: 0,
                    bottom: 0,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: SizedBox(
                        width: width * 0.31,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 14 * s,
                                  fontWeight: FontWeight.w800,
                                  color: HomeStyles.titleColor,
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(text: '${banner.title} '),
                                  TextSpan(
                                    text: banner.highlight,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5 * s),
                            Text(
                              banner.subtitle,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10 * s,
                                color: HomeStyles.bodyColor,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 10 * s),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10 * s,
                                    vertical: 6 * s,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.primaryGradient,
                                    borderRadius: BorderRadius.circular(9 * s),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        banner.buttonLabel,
                                        style: TextStyle(
                                          fontSize: 10.5 * s,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 5 * s),
                                      Icon(
                                        SolarIconsOutline.arrowRight,
                                        size: 13 * s,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
