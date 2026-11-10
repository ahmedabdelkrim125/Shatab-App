import 'package:flutter/material.dart';
import 'package:shatab/core/routing/app_routes.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/widgets/app_button.dart';
import 'package:shatab/feats/onboarding/models/onboarding_item.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/responsive_extension.dart';
import '../../../core/utils/spacing.dart';
import 'widgets/onboarding_dots.dart';
import 'widgets/onboarding_item_view.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final AnimationController _floatController;
  late final Animation<double> _float;
  final List<OnboardingItem> _items = OnboardingItem.items;
  int _currentIndex = 0;

  bool get _isLast => _currentIndex == _items.length - 1;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _float = CurvedAnimation(parent: _floatController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_isLast) {
      _finish();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutCubic,
    );
  }

  void _finish() {
    context.pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.onboardingBackground,
        ),
        child: SafeArea(
          child: AdaptiveContentWrapper(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: _finish,
                      child: Text('تخطي', style: AppTextStyles.link),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _items.length,
                    onPageChanged: (value) =>
                        setState(() => _currentIndex = value),
                    itemBuilder: (context, index) {
                      return OnboardingItemView(
                        item: _items[index],
                        index: index,
                        pageController: _pageController,
                        floatAnimation: _float,
                        isActive: index == _currentIndex,
                      );
                    },
                  ),
                ),
                OnboardingDots(
                  controller: _pageController,
                  count: _items.length,
                ),
                verticalSpace(height: 28),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: AppButton(
                    text: _isLast ? 'ابدأ الآن' : 'التالي',
                    onPressed: _onNext,
                    borderRadius: 12,
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    icon: const Icon(SolarIconsOutline.arrowRight),
                    iconAtStart: true,
                    iconAtEdge: true,
                    animateIcon: true,
                    reverseIconMotion: true,
                    showShine: true,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),
                verticalSpace(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
