import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import '../utils/responsive_extension.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    this.text,
    this.onPressed,
    this.child,
    this.icon,
    this.iconAtStart = false,
    this.iconAtEdge = false,
    this.iconSpacing = 10,
    this.iconBackgroundColor,
    this.iconContainerSize = 36,
    this.iconContainerRadius = 10,
    this.animateIcon = false,
    this.reverseIconMotion = false,
    this.showShine = false,
    this.shineColor,
    this.textStyle,
    this.textColor,
    this.backgroundColor,
    this.gradient,
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius = 12,
    this.width,
    this.height = 56,
    this.padding,
    this.margin,
    this.boxShadow,
    this.alignment = Alignment.center,
    this.isLoading = false,
    this.isEnabled = true,
    this.isExpanded = true,
    this.loadingColor,
    this.splashColor,
    this.pressScale = 0.97,
    this.disabledOpacity = 0.5,
  });

  final String? text;
  final VoidCallback? onPressed;
  final Widget? child;
  final Widget? icon;
  final bool iconAtStart;
  final bool iconAtEdge;
  final double iconSpacing;
  final Color? iconBackgroundColor;
  final double iconContainerSize;
  final double iconContainerRadius;
  final bool animateIcon;
  final bool reverseIconMotion;
  final bool showShine;
  final Color? shineColor;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final AlignmentGeometry alignment;
  final bool isLoading;
  final bool isEnabled;
  final bool isExpanded;
  final Color? loadingColor;
  final Color? splashColor;
  final double pressScale;
  final double disabledOpacity;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _loop;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _loop = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    _syncLoop();
  }

  @override
  void didUpdateWidget(covariant AppButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncLoop();
  }

  void _syncLoop() {
    final shouldRun =
        (widget.animateIcon || widget.showShine) &&
        widget.isEnabled &&
        !widget.isLoading;
    if (shouldRun && !_loop.isAnimating) {
      _loop.repeat();
    } else if (!shouldRun && _loop.isAnimating) {
      _loop.stop();
    }
  }

  @override
  void dispose() {
    _loop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _loop,
      builder: (context, _) => _buildButton(context),
    );
  }

  Widget _buildButton(BuildContext context) {
    final w = widget;
    final active = w.isEnabled && w.onPressed != null && !w.isLoading;
    final radius = BorderRadius.circular(w.borderRadius.r);
    final Gradient? gradient =
        w.gradient ??
        (w.backgroundColor == null ? AppColors.primaryGradient : null);
    final textStyle = (w.textStyle ?? AppTextStyles.button).copyWith(
      color: w.textColor,
    );
    final contentColor = textStyle.color ?? AppColors.white;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: w.isEnabled ? 1 : w.disabledOpacity,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        scale: _pressed ? w.pressScale : 1,
        child: Container(
          margin: w.margin,
          width: w.width != null
              ? w.width!.w
              : (w.isExpanded ? double.infinity : null),
          height: w.height?.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: gradient == null ? w.backgroundColor : null,
            gradient: gradient,
            borderRadius: radius,
            border: w.borderWidth > 0
                ? Border.all(
                    color: w.borderColor ?? AppColors.primary,
                    width: w.borderWidth.w,
                  )
                : null,
            boxShadow: w.boxShadow,
          ),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: active ? w.onPressed : null,
                  onHighlightChanged: (value) {
                    if (_pressed != value) setState(() => _pressed = value);
                  },
                  borderRadius: radius,
                  splashColor:
                      w.splashColor ?? AppColors.white.withValues(alpha: 0.18),
                  highlightColor: Colors.transparent,
                  child: Padding(
                    padding:
                        w.padding ?? EdgeInsets.symmetric(horizontal: 16.w),
                    child: Align(
                      alignment: w.alignment,
                      widthFactor: w.isExpanded || w.width != null ? null : 1,
                      child: IconTheme(
                        data: IconThemeData(color: contentColor, size: 22.sp),
                        child: _buildContent(context, textStyle, contentColor),
                      ),
                    ),
                  ),
                ),
              ),
              if (w.showShine && active) _buildShine(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShine() {
    const shineEnd = 0.45;
    final t = Curves.easeInOut.transform(
      (_loop.value / shineEnd).clamp(0.0, 1.0),
    );
    final x = -1.8 + 3.6 * t;
    final color = widget.shineColor ?? AppColors.white;

    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: _loop.value < shineEnd ? 1 : 0,
          child: Align(
            alignment: AlignmentDirectional(x, 0),
            child: FractionallySizedBox(
              widthFactor: 0.28,
              heightFactor: 1,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.skewX(-0.35),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0),
                        color.withValues(alpha: 0.28),
                        color.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildIcon(BuildContext context) {
    final w = widget;
    final icon = w.icon;
    if (icon == null) return null;

    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final local = ((_loop.value - 0.5) / 0.5).clamp(0.0, 1.0);
    final pulse = w.animateIcon ? math.sin(math.pi * local) : 0.0;
    final dx = pulse * 5 * (isRtl ? -1 : 1) * (w.reverseIconMotion ? -1 : 1);

    final moving = Transform.translate(offset: Offset(dx, 0), child: icon);
    final boxed = w.iconAtEdge || w.iconBackgroundColor != null;
    if (!boxed) return moving;

    return Container(
      width: w.iconContainerSize.w,
      height: w.iconContainerSize.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: w.iconBackgroundColor ?? AppColors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(w.iconContainerRadius.r),
      ),
      child: moving,
    );
  }

  Widget _buildContent(
    BuildContext context,
    TextStyle textStyle,
    Color contentColor,
  ) {
    final w = widget;

    if (w.isLoading) {
      return SizedBox(
        width: 22.w,
        height: 22.w,
        child: CircularProgressIndicator(
          strokeWidth: 2.2,
          valueColor: AlwaysStoppedAnimation<Color>(
            w.loadingColor ?? contentColor,
          ),
        ),
      );
    }

    if (w.child != null) return w.child!;

    final Widget? label = w.text == null
        ? null
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.35),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Text(
              w.text!,
              key: ValueKey<String>(w.text!),
              style: textStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );

    final icon = _buildIcon(context);
    if (icon == null) return label ?? const SizedBox.shrink();
    if (label == null) return icon;

    final canSpread = w.iconAtEdge && (w.isExpanded || w.width != null);
    if (canSpread) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (w.iconAtStart) icon else SizedBox(width: w.iconContainerSize.w),
          Expanded(child: Center(child: label)),
          if (w.iconAtStart) SizedBox(width: w.iconContainerSize.w) else icon,
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (w.iconAtStart) ...[icon, SizedBox(width: w.iconSpacing.w)],
        Flexible(child: label),
        if (!w.iconAtStart) ...[SizedBox(width: w.iconSpacing.w), icon],
      ],
    );
  }
}
