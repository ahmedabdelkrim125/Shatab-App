import 'package:shatab/core/const/images_app.dart';

class VerifiedProject {
  const VerifiedProject({
    required this.title,
    required this.district,
    required this.area,
    required this.finishingType,
    required this.duration,
    required this.providerName,
    required this.imagePath,
    this.costRange,
  });

  final String title;
  final String district;
  final int area;
  final String finishingType;
  final String duration;
  final String providerName;
  final String imagePath;
  final String? costRange;

  static const List<VerifiedProject> samples = [
    VerifiedProject(
      title: 'شقة عصرية بتشطيب كامل',
      district: 'التجمع الخامس',
      area: 140,
      finishingType: 'سوبر لوكس',
      duration: '14 أسبوع',
      providerName: 'شركة النخبة',
      imagePath: ImagesApp.livingRoom,
      costRange: '780 - 850 ألف',
    ),
    VerifiedProject(
      title: 'تجديد شقة بطابع مودرن',
      district: 'مدينة نصر',
      area: 110,
      finishingType: 'لوكس',
      duration: '9 أسابيع',
      providerName: 'م. محمد سمير',
      imagePath: ImagesApp.bannerBackground,
    ),
    VerifiedProject(
      title: 'دوبلكس بتصميم داخلي متكامل',
      district: 'الشيخ زايد',
      area: 210,
      finishingType: 'ألترا لوكس',
      duration: '20 أسبوع',
      providerName: 'م. سارة أحمد',
      imagePath: ImagesApp.modernVilla,
      costRange: '1.8 - 2.1 مليون',
    ),
    VerifiedProject(
      title: 'شقة من الطوب للتسليم',
      district: 'أكتوبر',
      area: 120,
      finishingType: 'لوكس',
      duration: '11 أسبوع',
      providerName: 'شركة النخبة',
      imagePath: ImagesApp.finishingBackground,
    ),
  ];
}
