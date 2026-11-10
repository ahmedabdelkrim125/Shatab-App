import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shatab/core/routing/app_routes.dart';
import 'package:shatab/core/theme/app_theme.dart';

import '../../core/const/images_app.dart';
import '../../core/utils/extensions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _reveal;
  late final Animation<double> _scale;
  late final Animation<double> _shimmer;
  late final Animation<double> _ripple;
  late final Animation<double> _exit;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    );
    _reveal = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
    );
    _scale = Tween<double>(begin: 0.6, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutBack),
      ),
    );
    _shimmer = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 0.78, curve: Curves.easeInOut),
    );
    _ripple = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );
    _exit = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.88, 1.0, curve: Curves.easeInCubic),
    );
    _controller.forward().whenComplete(_goNext);
  }

  void _goNext() {
    if (!mounted) return;
    context.pushReplacementNamed(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final imageWidth = size.width * 0.78;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final exit = _exit.value;
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _RipplePainter(
                    progress: _ripple.value,
                    fade: 1 - exit,
                  ),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: (_reveal.value.clamp(0.0, 1.0) * (1 - exit)),
                  child: Transform.scale(
                    scale: _scale.value * (1 + exit * 0.08),
                    child: ClipPath(
                      clipper: _CircleRevealClipper(_reveal.value),
                      child: ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white.withValues(alpha: 0),
                              Colors.white.withValues(alpha: 0.9),
                              Colors.white.withValues(alpha: 0),
                            ],
                            stops: const [0.35, 0.5, 0.65],
                            transform: _SlideGradientTransform(
                              -1 + 2 * _shimmer.value,
                            ),
                          ).createShader(rect);
                        },
                        child: Image.asset(
                          ImagesApp.splash,
                          width: imageWidth,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CircleRevealClipper extends CustomClipper<Path> {
  const _CircleRevealClipper(this.fraction);

  final double fraction;

  @override
  Path getClip(Size size) {
    final radius =
        math.sqrt(size.width * size.width + size.height * size.height) /
        2 *
        fraction;
    return Path()
      ..addOval(
        Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
      );
  }

  @override
  bool shouldReclip(covariant _CircleRevealClipper oldClipper) =>
      oldClipper.fraction != fraction;
}

class _SlideGradientTransform extends GradientTransform {
  const _SlideGradientTransform(this.percent);

  final double percent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * percent, 0, 0);
  }
}

class _RipplePainter extends CustomPainter {
  const _RipplePainter({required this.progress, required this.fade});

  final double progress;
  final double fade;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.longestSide * 0.6;

    final glowRadius = size.shortestSide * 0.45 * progress;
    if (glowRadius > 0) {
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.08 * fade),
            AppColors.primary.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: glowRadius));
      canvas.drawCircle(center, glowRadius, glowPaint);
    }

    for (var i = 0; i < 3; i++) {
      final local = ((progress - i * 0.15) / (1 - i * 0.15)).clamp(0.0, 1.0);
      if (local <= 0) continue;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = AppColors.primary.withValues(
          alpha: (1 - local) * 0.22 * fade,
        );
      canvas.drawCircle(center, maxRadius * local, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RipplePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.fade != fade;
}