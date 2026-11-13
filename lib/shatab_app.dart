import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shatab/core/routing/app_router.dart';
import 'package:shatab/core/routing/app_routes.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'core/utils/responsive_extension.dart';

class ShatabApp extends StatelessWidget {
  const ShatabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'شطب',
      theme: AppTheme.light,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      builder: (context, child) {
        return ResponsiveInit(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
