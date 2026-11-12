import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:solar_icons/solar_icons.dart';
import 'auth_styles.dart';

class PortfolioPicker extends StatelessWidget {
  const PortfolioPicker({
    super.key,
    required this.images,
    required this.onChanged,
    required this.maxImages,
  });

  final List<XFile> images;
  final ValueChanged<List<XFile>> onChanged;
  final int maxImages;

  Future<void> _pick() async {
    final remaining = maxImages - images.length;
    if (remaining <= 0) return;
    try {
      final picked = await ImagePicker().pickMultiImage(
        maxWidth: 1600,
        imageQuality: 80,
      );
      if (picked.isEmpty) return;
      final existing = images.map((e) => e.path).toSet();
      final fresh = picked
          .where((e) => !existing.contains(e.path))
          .take(remaining);
      onChanged([...images, ...fresh]);
    } catch (_) {
      return;
    }
  }

  void _remove(int index) {
    final updated = [...images]..removeAt(index);
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = 10.w;
        final size = (constraints.maxWidth - gap * 2) / 3;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'صور من أعمالك السابقة',
                    style: AuthStyles.input.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text('${images.length}/$maxImages', style: AuthStyles.body),
              ],
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (var i = 0; i < images.length; i++)
                  _Thumb(
                    path: images[i].path,
                    size: size,
                    onRemove: () => _remove(i),
                  ),
                if (images.length < maxImages)
                  _AddTile(size: size, onTap: _pick),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({
    required this.path,
    required this.size,
    required this.onRemove,
  });

  final String path;
  final double size;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.file(File(path), fit: BoxFit.cover, cacheWidth: 400),
            ),
          ),
          PositionedDirectional(
            top: 6.h,
            end: 6.w,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  SolarIconsOutline.closeCircle,
                  size: 20.sp,
                  color: AuthStyles.errorColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({required this.size, required this.onTap});

  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16.r);

    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: const BorderSide(color: AuthStyles.borderColor),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                SolarIconsOutline.galleryAdd,
                size: 28.sp,
                color: AppColors.primary,
              ),
              SizedBox(height: 6.h),
              Text('إضافة', style: AuthStyles.body),
            ],
          ),
        ),
      ),
    );
  }
}
