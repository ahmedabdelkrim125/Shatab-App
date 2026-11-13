import 'package:flutter/material.dart';
import 'package:shatab/core/routing/app_routes.dart';
import 'package:shatab/feats/splash/splash_page.dart';
import '../../feats/auth/login/ui/login_page.dart';
import '../../feats/auth/register/ui/register_page.dart';
import '../../feats/auth/widgets/role_selection_page.dart';
import '../../feats/onboarding/ui/onboarding_page.dart';
import '../../feats/auth/models/user_role.dart';
import '../../feats/main/ui/main_page.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return _fade(const OnboardingPage(), settings);
      case AppRoutes.login:
        return _slideFade(const LoginPage(), settings);
      case AppRoutes.roleSelection:
        return _slideFade(const RoleSelectionPage(), settings);
      case AppRoutes.register:
        final arguments = settings.arguments;
        final role = arguments is UserRole ? arguments : UserRole.homeowner;
        return _slideFade(RegisterPage(role: role), settings);
      case AppRoutes.main:
        final arguments = settings.arguments;
        final role = arguments is UserRole ? arguments : UserRole.homeowner;
        return _fade(MainPage(role: role), settings);
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
