import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:solar_icons/solar_icons.dart';
import 'auth_styles.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.autofillHints,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final String? Function(String?) validator;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? maxLength;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;

  bool get _multiline => widget.maxLines > 1;

  OutlineInputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_multiline ? 22.r : 30.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword && _obscure,
      keyboardType:
          widget.keyboardType ??
          (_multiline ? TextInputType.multiline : null),
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onSubmitted,
      autofillHints: widget.autofillHints,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      minLines: _multiline ? widget.maxLines : null,
      maxLength: widget.maxLength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      cursorColor: AppColors.primary,
      style: AuthStyles.input,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintText: widget.hint,
        hintStyle: AuthStyles.hint,
        errorStyle: AuthStyles.error,
        errorMaxLines: 2,
        counterText: '',
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        prefixIcon: Icon(widget.icon, size: 22.sp, color: AuthStyles.iconColor),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure ? SolarIconsOutline.eye : SolarIconsOutline.eyeClosed,
                  size: 22.sp,
                  color: AuthStyles.iconColor,
                ),
              )
            : null,
        border: _border(AuthStyles.borderColor),
        enabledBorder: _border(AuthStyles.borderColor),
        focusedBorder: _border(AppColors.primary, 1.4),
        errorBorder: _border(AuthStyles.errorColor),
        focusedErrorBorder: _border(AuthStyles.errorColor, 1.4),
      ),
    );
  }
}
