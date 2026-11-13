import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/feats/home/models/promo_banner.dart';
import 'promo_banner_card.dart';

class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({
    super.key,
    this.banners = PromoBanner.defaults,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.onBannerTap,
  });

  final List<PromoBanner> banners;
  final Duration autoPlayInterval;
  final ValueChanged<PromoBanner>? onBannerTap;

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    if (widget.banners.length < 2) return;
    _timer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!_controller.hasClients) return;
      final next = (_current + 1) % widget.banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _stopTimer() => _timer?.cancel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 168.h,
          child: Listener(
            onPointerDown: (_) => _stopTimer(),
            onPointerUp: (_) => _startTimer(),
            onPointerCancel: (_) => _startTimer(),
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.banners.length,
              onPageChanged: (value) => setState(() => _current = value),
              itemBuilder: (context, index) {
                final banner = widget.banners[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: PromoBannerCard(
                    banner: banner,
                    onTap: widget.onBannerTap == null
                        ? null
                        : () => widget.onBannerTap!(banner),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.banners.length; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: i == _current ? 22.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: i == _current
                        ? AppColors.primary
                        : AppColors.primaryLight.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
