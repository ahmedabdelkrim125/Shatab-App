import 'package:flutter/widgets.dart';
import 'package:solar_icons/solar_icons.dart';

class ServiceCategory {
  const ServiceCategory({required this.label, required this.icon});

  final String label;
  final IconData icon;

  static const List<ServiceCategory> defaults = [
    ServiceCategory(label: 'نقاشة', icon: SolarIconsOutline.paintRoller),
    ServiceCategory(label: 'كهرباء', icon: SolarIconsOutline.bolt),
    ServiceCategory(label: 'سباكة', icon: SolarIconsOutline.waterdrop),
    ServiceCategory(label: 'سيراميك', icon: SolarIconsOutline.widget),
    ServiceCategory(label: 'نجارة', icon: SolarIconsOutline.rulerPen),
  ];
}
