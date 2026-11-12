import 'package:flutter/widgets.dart';
import 'package:shatab/feats/auth/models/user_role.dart';
import 'package:solar_icons/solar_icons.dart';

class MainTab {
  const MainTab({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;

  static const MainTab _home = MainTab(
    label: 'الرئيسية',
    icon: SolarIconsOutline.home2,
    activeIcon: SolarIconsBold.home2,
  );

  static const MainTab _messages = MainTab(
    label: 'الرسائل',
    icon: SolarIconsOutline.chatRoundDots,
    activeIcon: SolarIconsBold.chatRoundDots,
  );

  static const MainTab _profile = MainTab(
    label: 'حسابي',
    icon: SolarIconsOutline.userRounded,
    activeIcon: SolarIconsBold.userRounded,
  );

  static const List<MainTab> homeowner = [
    _home,
    MainTab(
      label: 'استكشف',
      icon: SolarIconsOutline.magnifier,
      activeIcon: SolarIconsBold.magnifier,
    ),
    MainTab(
      label: 'طلباتي',
      icon: SolarIconsOutline.clipboardList,
      activeIcon: SolarIconsBold.clipboardList,
    ),
    _messages,
    _profile,
  ];

  static const List<MainTab> provider = [
    _home,
    MainTab(
      label: 'الطلبات',
      icon: SolarIconsOutline.clipboardList,
      activeIcon: SolarIconsBold.clipboardList,
    ),
    _messages,
    _profile,
  ];

  static List<MainTab> forRole(UserRole role) {
    return role == UserRole.provider ? provider : homeowner;
  }
}