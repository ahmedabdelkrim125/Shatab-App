import 'package:shatab/core/const/images_app.dart';

enum UserRole {
  homeowner(
    title: 'صاحب منزل',
    description: 'أبحث عن مهندس أو شركة أو فني لتشطيب شقتي',
    image: ImagesApp.roleHomeowner,
  ),
  provider(
    title: 'مقدم خدمة',
    description: 'مهندس أو مقاول أو فني، وأريد عرض أعمالي واستقبال العملاء',
    image: ImagesApp.roleProvider,
  );

  const UserRole({
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;
}
