import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/feats/onboarding/models/onboarding_item.dart';
import 'package:shatab/feats/onboarding/ui/widgets/highlighted_title.dart';
import 'package:shatab/feats/onboarding/ui/widgets/page_offset_extension.dart';
import '../../../../core/utils/responsive_extension.dart';

class OnboardingItemView extends StatelessWidget {
  const OnboardingItemView({
    super.key,
    required this.item,
    required this.index,
    required this.pageController,
    required this.floatAnimation,
    required this.isActive,
  });

  final OnboardingItem item;
  final int index;
  final PageController pageController;
  final Animation<double> floatAnimation;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final direction = isRtl ? -1.0 : 1.0;
    final width = MediaQuery.sizeOf(context).width;

    return AnimatedBuilder(
      animation: Listenable.merge([pageController, floatAnimation]),
      builder: (context, _) {
        final delta = (pageController.currentPage - index)
            .clamp(-1.0, 1.0)
            .toDouble();
        final abs = delta.abs();
        final floatY = (floatAnimation.value * 14 - 7).h;
        final textOpacity = (1 - abs * 1.5).clamp(0.0, 1.0).toDouble();
        final imageOpacity = (1 - abs * 1.2).clamp(0.0, 1.0).toDouble();

        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Center(
                  child: Transform.translate(
                    offset: Offset(direction * delta * width * 0.3, floatY),
                    child: Transform.rotate(
                      angle: delta * 0.1,
                      child: Transform.scale(
                        scale: 1 - abs * 0.18,
                        child: Opacity(
                          opacity: imageOpacity,
                          child: Image.asset(item.image, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Opacity(
              opacity: textOpacity,
              child: Transform.translate(
                offset: Offset(0, abs * 30),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: HighlightedTitle(
                        prefix: item.prefix,
                        highlight: item.highlight,
                        suffix: item.suffix,
                        animate: isActive,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.onboardingDescription,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        );
      },
    );
  }
}
