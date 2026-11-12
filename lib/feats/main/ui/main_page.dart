import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/feats/auth/models/user_role.dart';

import '../widgets/app_nav_bar.dart';
import '../widgets/main_tab.dart';
import '../widgets/tab_placeholder.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.role});

  final UserRole role;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  late final List<MainTab> _tabs = MainTab.forRole(widget.role);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) setState(() => _index = 0);
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.onboardingBackground,
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: _index,
                    children: [
                      for (final tab in _tabs) TabPlaceholder(tab: tab),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: AppNavBar(
                    tabs: _tabs,
                    currentIndex: _index,
                    onTap: (value) => setState(() => _index = value),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
