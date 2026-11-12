import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/core/widgets/app_button.dart';
import 'auth_styles.dart';

Future<void> showAuthSuccessDialog({
  required BuildContext context,
  required String title,
  required String message,
  VoidCallback? onContinue,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'success',
    barrierColor: Colors.black.withValues(alpha: 0.45),
    transitionDuration: const Duration(milliseconds: 320),
    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      return _SuccessCard(
        title: title,
        message: message,
        onContinue: () {
          Navigator.of(dialogContext).pop();
          onContinue?.call();
        },
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _SuccessCard extends StatefulWidget {
  const _SuccessCard({
    required this.title,
    required this.message,
    required this.onContinue,
  });

  final String title;
  final String message;
  final VoidCallback onContinue;

  @override
  State<_SuccessCard> createState() => _SuccessCardState();
}

class _SuccessCardState extends State<_SuccessCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _ripple;
  late final Animation<double> _check;
  late final Animation<double> _text;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.4, curve: Curves.easeOutBack),
    );
    _ripple = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1, curve: Curves.easeOut),
    );
    _check = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.8, curve: Curves.easeOutCubic),
    );
    _text = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      HapticFeedback.lightImpact();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _badge() {
    final size = 96.w;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final rippleValue = _ripple.value;
        return SizedBox(
          width: size * 1.7,
          height: size * 1.7,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: rippleValue <= 0
                    ? 0
                    : ((1 - rippleValue) * 0.3).clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: 0.85 + rippleValue * 0.75,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: _scale.value,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CustomPaint(painter: _CheckPainter(_check.value)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 360.w),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 24.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(28.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _badge(),
                  SizedBox(height: 8.h),
                  FadeTransition(
                    opacity: _text,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.15),
                        end: Offset.zero,
                      ).animate(_text),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: AuthStyles.title.copyWith(fontSize: 22.sp),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            widget.message,
                            textAlign: TextAlign.center,
                            style: AuthStyles.subtitle,
                          ),
                          SizedBox(height: 28.h),
                          AppButton(
                            text: 'متابعة',
                            onPressed: widget.onContinue,
                            borderRadius: 30,
                            height: 54,
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
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  const _CheckPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final path = Path()
      ..moveTo(size.width * 0.28, size.height * 0.52)
      ..lineTo(size.width * 0.44, size.height * 0.67)
      ..lineTo(size.width * 0.74, size.height * 0.36);

    final metric = path.computeMetrics().first;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = size.width * 0.085;

    canvas.drawPath(metric.extractPath(0, metric.length * progress), paint);
  }

  @override
  bool shouldRepaint(covariant _CheckPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
