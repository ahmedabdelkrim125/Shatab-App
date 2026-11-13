import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/feats/onboarding/ui/widgets/page_offset_extension.dart';
import '../../../../core/utils/responsive_extension.dart';

class OnboardingDots extends StatelessWidget {
  const OnboardingDots({
    super.key,
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    final dot = 10.w;
    final gap = 12.w;
    final width = count * dot + (count - 1) * gap;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return CustomPaint(
          size: Size(width, dot * 1.8),
          painter: _WormDotsPainter(
            page: controller.currentPage,
            count: count,
            isRtl: false,
            dot: dot,
            gap: gap,
          ),
        );
      },
    );
  }
}

class _WormDotsPainter extends CustomPainter {
  const _WormDotsPainter({
    required this.page,
    required this.count,
    required this.isRtl,
    required this.dot,
    required this.gap,
  });

  final double page;
  final int count;
  final bool isRtl;
  final double dot;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final cy = size.height / 2;
    final r = dot / 2;
    final step = dot + gap;

    double cx(double index) {
      final x = r + index * step;
      return isRtl ? size.width - x : x;
    }

    final idlePaint = Paint()
      ..color = AppColors.primaryLight.withValues(alpha: 0.55);
    for (var i = 0; i < count; i++) {
      canvas.drawCircle(Offset(cx(i.toDouble()), cy), r, idlePaint);
    }

    final p = page.clamp(0.0, count - 1.0);
    final base = p.floorToDouble();
    final t = p - base;
    final lead = base + Curves.easeOut.transform(t);
    final tail = base + Curves.easeIn.transform(t);

    final xa = cx(lead);
    final xb = cx(tail);
    final left = (xa < xb ? xa : xb) - r;
    final right = (xa > xb ? xa : xb) + r;

    final rect = Rect.fromLTRB(left, cy - r, right, cy + r);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(r));

    canvas.drawRRect(
      rrect.shift(const Offset(0, 2)),
      Paint()
        ..color = AppColors.primary.withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _WormDotsPainter oldDelegate) =>
      oldDelegate.page != page ||
      oldDelegate.count != count ||
      oldDelegate.isRtl != isRtl;
}
