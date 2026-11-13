import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/feats/auth/models/user_role.dart';
import 'package:shatab/feats/home/ui/homeowner_home_page.dart';
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

  Widget _pageFor(int index) {
    if (index == 0 && widget.role == UserRole.homeowner) {
      return const HomeownerHomePage();
    }
    return TabPlaceholder(tab: _tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    final navClearance = 70.w + 24.h;

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
            child: Builder(
              builder: (context) {
                final innerQuery = MediaQuery.of(context);

                return Stack(
                  children: [
                    Positioned.fill(
                      child: MediaQuery(
                        data: innerQuery.copyWith(
                          padding: innerQuery.padding.copyWith(
                            bottom: innerQuery.padding.bottom + navClearance,
                          ),
                        ),
                        child: IndexedStack(
                          index: _index,
                          children: [
                            for (var i = 0; i < _tabs.length; i++) _pageFor(i),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: AppNavBar(
                          tabs: _tabs,
                          currentIndex: _index,
                          onTap: (value) => setState(() => _index = value),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
