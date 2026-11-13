import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import '../../../../core/utils/responsive_extension.dart';

class HighlightedTitle extends StatelessWidget {
  const HighlightedTitle({
    super.key,
    required this.prefix,
    required this.highlight,
    required this.suffix,
    required this.animate,
  });

  final String prefix;
  final String highlight;
  final String suffix;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.onboardingTitle;

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: prefix),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _AnimatedHighlight(
              text: highlight,
              style: style.copyWith(color: AppColors.primary),
              animate: animate,
            ),
          ),
          TextSpan(text: suffix),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _AnimatedHighlight extends StatelessWidget {
  const _AnimatedHighlight({
    required this.text,
    required this.style,
    required this.animate,
  });

  final String text;
  final TextStyle style;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: animate ? 1 : 0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      child: Text(text, style: style),
      builder: (context, value, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            child!,
            Positioned(
              left: 0,
              right: 0,
              bottom: -4.h,
              height: 10.h,
              child: CustomPaint(painter: _SwooshPainter(value)),
            ),
          ],
        );
      },
    );
  }
}

class _SwooshPainter extends CustomPainter {
  const _SwooshPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final path = Path()
      ..moveTo(size.width, size.height * 0.25)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 1.15,
        0,
        size.height * 0.2,
      );

    final metric = path.computeMetrics().first;
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.2;

    canvas.drawPath(metric.extractPath(0, metric.length * progress), paint);
  }

  @override
  bool shouldRepaint(covariant _SwooshPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
