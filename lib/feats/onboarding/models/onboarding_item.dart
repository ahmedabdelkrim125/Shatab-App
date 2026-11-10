import '../../../core/const/images_app.dart';

class OnboardingItem {
  const OnboardingItem({
    required this.image,
    required this.prefix,
    required this.highlight,
    required this.suffix,
    required this.description,
  });

  final String image;
  final String prefix;
  final String highlight;
  final String suffix;
  final String description;

  static const List<OnboardingItem> items = [
    OnboardingItem(
      image: ImagesApp.onboarding1,
      prefix: '',
      highlight: 'شطّب',
      suffix: ' منزلك بسهولة',
      description:
          'من التخطيط واختيار الخامات، إلى حساب التكلفة ومتابعة التنفيذ خطوة بخطوة.',
    ),
    OnboardingItem(
      image: ImagesApp.onboarding2,
      prefix: 'نفّذ ',
      highlight: 'تشطيبك',
      suffix: ' بثقة',
      description:
          'تواصل مع مقاولين محترفين، واختر أفضل الخامات لمشروعك مع ضمان على التنفيذ.',
    ),
    OnboardingItem(
      image: ImagesApp.onboarding3,
      prefix: 'من الفكرة إلى ',
      highlight: 'السكن',
      suffix: '',
      description:
          'استلهم أفكار تشطيب عصرية، احسب تكلفتك بدقة، وتابع تنفيذ مشروعك حتى الاستلام.',
    ),
  ];
}