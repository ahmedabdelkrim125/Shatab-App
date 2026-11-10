import 'package:flutter/material.dart';
import 'package:shatab/core/routing/app_routes.dart';
import 'package:shatab/feats/splash/splash_page.dart';
import '../../feats/onboarding/ui/onboarding_page.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return _fade(const OnboardingPage(), settings);
      case AppRoutes.login:
        return _slideFade(const _LoginPlaceholder(), settings);
      case AppRoutes.splash:
      default:
        return _fade(const SplashPage(), settings);
    }
  }

  static PageRoute<dynamic> _fade(Widget page, RouteSettings settings) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static PageRoute<dynamic> _slideFade(Widget page, RouteSettings settings) {
    final curve = CurveTween(curve: Curves.easeOutCubic);
    final offset = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    );

    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation.drive(curve),
          child: SlideTransition(
            position: animation.drive(offset.chain(curve)),
            child: child,
          ),
        );
      },
    );
  }
}

class _LoginPlaceholder extends StatelessWidget {
  const _LoginPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('تسجيل الدخول')));
  }
}