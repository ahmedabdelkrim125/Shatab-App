import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/core/widgets/app_button.dart';
import 'package:solar_icons/solar_icons.dart';
import 'auth_styles.dart';

class AuthSelectField extends FormField<List<String>> {
  AuthSelectField({
    super.key,
    required String hint,
    required String sheetTitle,
    required IconData icon,
    required List<String> options,
    required String? Function(List<String>?) validator,
    List<String> initialValue = const [],
    ValueChanged<List<String>>? onChanged,
    bool multi = false,
    int? maxSelection,
  }) : super(
         initialValue: initialValue,
         validator: validator,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         builder: (state) {
           final context = state.context;
           final selected = state.value ?? const <String>[];
           final hasValue = selected.isNotEmpty;
           final hasError = state.hasError;
           final radius = BorderRadius.circular(30.r);

           Future<void> open() async {
             FocusScope.of(context).unfocus();
             final result = await showModalBottomSheet<List<String>>(
               context: context,
               isScrollControlled: true,
               backgroundColor: Colors.transparent,
               builder: (_) => _SelectSheet(
                 title: sheetTitle,
                 options: options,
                 selected: selected,
                 multi: multi,
                 maxSelection: maxSelection,
               ),
             );
             if (result == null) return;
             state.didChange(result);
             onChanged?.call(result);
           }

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Material(
                 color: AppColors.white,
                 shape: RoundedRectangleBorder(
                   borderRadius: radius,
                   side: BorderSide(
                     color: hasError
                         ? AuthStyles.errorColor
                         : AuthStyles.borderColor,
                   ),
                 ),
                 child: InkWell(
                   onTap: open,
                   borderRadius: radius,
                   child: Padding(
                     padding: EdgeInsets.symmetric(
                       horizontal: 20.w,
                       vertical: 18.h,
                     ),
                     child: Row(
                       children: [
                         Icon(icon, size: 22.sp, color: AuthStyles.iconColor),
                         SizedBox(width: 12.w),
                         Expanded(
                           child: Text(
                             hasValue ? selected.join('، ') : hint,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                             style: hasValue
                                 ? AuthStyles.input
                                 : AuthStyles.hint,
                           ),
                         ),
                         Icon(
                           SolarIconsOutline.altArrowDown,
                           size: 20.sp,
                           color: AuthStyles.iconColor,
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
               if (hasError)
                 Padding(
                   padding: EdgeInsets.only(top: 8.h, right: 20.w, left: 20.w),
                   child: Text(state.errorText!, style: AuthStyles.error),
                 ),
             ],
           );
         },
       );
}

class _SelectSheet extends StatefulWidget {
  const _SelectSheet({
    required this.title,
    required this.options,
    required this.selected,
    required this.multi,
    required this.maxSelection,
  });

  final String title;
  final List<String> options;
  final List<String> selected;
  final bool multi;
  final int? maxSelection;

  @override
  State<_SelectSheet> createState() => _SelectSheetState();
}

class _SelectSheetState extends State<_SelectSheet> {
  late final Set<String> _selected = {...widget.selected};

  void _toggle(String option) {
    if (!widget.multi) {
      Navigator.of(context).pop(<String>[option]);
      return;
    }
    setState(() {
      if (_selected.contains(option)) {
        _selected.remove(option);
        return;
      }
      final max = widget.maxSelection;
      if (max == null || _selected.length < max) _selected.add(option);
    });
  }

  void _confirm() {
    final ordered = widget.options.where(_selected.contains).toList();
    Navigator.of(context).pop(ordered);
  }

  @override
  Widget build(BuildContext context) {
    final max = widget.maxSelection;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 44.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AuthStyles.borderColor,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: AuthStyles.titleColor,
              ),
            ),
            if (widget.multi && max != null)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text('اختر حتى $max خيارات', style: AuthStyles.body),
              ),
            SizedBox(height: 8.h),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  final option = widget.options[index];
                  final isSelected = _selected.contains(option);
                  return InkWell(
                    onTap: () => _toggle(option),
                    borderRadius: BorderRadius.circular(14.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 14.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option,
                              style: AuthStyles.input.copyWith(
                                color: isSelected
                                    ? AppColors.primary
                                    : AuthStyles.titleColor,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              SolarIconsOutline.checkCircle,
                              size: 24.sp,
                              color: AppColors.primary,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (widget.multi)
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 16.h),
                child: AppButton(
                  text: 'تأكيد',
                  onPressed: _confirm,
                  borderRadius: 30,
                  height: 54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
