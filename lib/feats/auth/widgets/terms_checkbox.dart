import 'package:flutter/material.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'auth_styles.dart';

class TermsCheckbox extends FormField<bool> {
  TermsCheckbox({
    super.key,
    required bool initialValue,
    required ValueChanged<bool> onChanged,
  }) : super(
         initialValue: initialValue,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         validator: (value) =>
             value == true ? null : 'يجب الموافقة على الشروط والأحكام للمتابعة',
         builder: (state) {
           final linkStyle = TextStyle(
             color: AppColors.primary,
             fontWeight: FontWeight.w700,
           );

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(
                     width: 24.w,
                     height: 24.w,
                     child: Checkbox(
                       value: state.value ?? false,
                       onChanged: (value) {
                         final checked = value ?? false;
                         state.didChange(checked);
                         onChanged(checked);
                       },
                       activeColor: AppColors.primary,
                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(6.r),
                       ),
                       side: BorderSide(
                         color: state.hasError
                             ? AuthStyles.errorColor
                             : AuthStyles.iconColor,
                         width: 1.5,
                       ),
                     ),
                   ),
                   SizedBox(width: 10.w),
                   Expanded(
                     child: Padding(
                       padding: EdgeInsets.only(top: 2.h),
                       child: Text.rich(
                         TextSpan(
                           style: AuthStyles.body.copyWith(height: 1.5),
                           children: [
                             const TextSpan(text: 'أوافق على '),
                             TextSpan(
                               text: 'الشروط والأحكام',
                               style: linkStyle,
                             ),
                             const TextSpan(text: ' و'),
                             TextSpan(text: 'سياسة الخصوصية', style: linkStyle),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(top: 6.h, right: 34.w),
                   child: Text(state.errorText!, style: AuthStyles.error),
                 ),
             ],
           );
         },
       );
}
