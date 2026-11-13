class FeaturedProvider {
  const FeaturedProvider({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewsCount,
    required this.verified,
  });

  final String name;
  final String specialty;
  final double rating;
  final int reviewsCount;
  final bool verified;

  static const List<FeaturedProvider> samples = [
    FeaturedProvider(
      name: 'شركة النخبة',
      specialty: 'شركة تشطيب',
      rating: 4.9,
      reviewsCount: 48,
      verified: true,
    ),
    FeaturedProvider(
      name: 'م. محمد سمير',
      specialty: 'مهندس تشطيبات',
      rating: 4.8,
      reviewsCount: 32,
      verified: true,
    ),
    FeaturedProvider(
      name: 'خالد عبد الله',
      specialty: 'نقاش',
      rating: 4.7,
      reviewsCount: 21,
      verified: false,
    ),
    FeaturedProvider(
      name: 'م. سارة أحمد',
      specialty: 'مصممة داخلية',
      rating: 4.8,
      reviewsCount: 27,
      verified: true,
    ),
  ];
}
