import 'package:flutter/material.dart';
import '../../../core/utils/responsive_extension.dart';
import 'widgets/featured_providers_section.dart';
import 'widgets/home_header.dart';
import 'widgets/promo_banner_carousel.dart';
import 'widgets/service_categories_section.dart';
import 'widgets/start_project_section.dart';
import 'widgets/verified_projects_section.dart';

class HomeownerHomePage extends StatelessWidget {
  const HomeownerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HomeHeader(),
          SizedBox(height: 24.h),
          const ServiceCategoriesSection(),
          SizedBox(height: 24.h),
          const PromoBannerCarousel(),
          SizedBox(height: 24.h),
          const StartProjectSection(),
          SizedBox(height: 24.h),
          const FeaturedProvidersSection(),
          SizedBox(height: 24.h),
          const VerifiedProjectsSection(),
        ],
      ),
    );
  }
}
