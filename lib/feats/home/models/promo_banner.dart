class PromoBanner {
  const PromoBanner({
    required this.title,
    required this.highlight,
    required this.subtitle,
    required this.buttonLabel,
  });

  final String title;
  final String highlight;
  final String subtitle;
  final String buttonLabel;

  static const List<PromoBanner> defaults = [
    PromoBanner(
      title: 'من أول فكرة لآخر',
      highlight: 'لمسة',
      subtitle: 'كل خدمات منزلك في مكان واحد',
      buttonLabel: 'اكتشف خدماتنا',
    ),
    PromoBanner(
      title: 'شطّب شقتك',
      highlight: 'بثقة',
      subtitle: 'قارن عروض الأسعار واختر الأنسب لك',
      buttonLabel: 'اطلب عرض سعر',
    ),
    PromoBanner(
      title: 'مهندسون وفنيون',
      highlight: 'موثوقون',
      subtitle: 'شاهد أعمالهم وتقييماتهم قبل أن تتواصل',
      buttonLabel: 'استعرض الأعمال',
    ),
  ];
}
