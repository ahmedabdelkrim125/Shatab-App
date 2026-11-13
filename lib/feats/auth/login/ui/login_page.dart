import 'package:flutter/material.dart';
import 'package:shatab/core/routing/app_routes.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/core/widgets/app_button.dart';
import 'package:shatab/feats/auth/models/user_role.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../../../core/utils/auth_validators.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_scaffold.dart';
import '../../widgets/auth_success_dialog.dart';
import '../../widgets/auth_switch_prompt.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/social_auth_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    showAuthSuccessDialog(
      context: context,
      title: 'تم تسجيل الدخول بنجاح',
      message: 'أهلاً بعودتك إلى شطب',
      onContinue: () => Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.main,
        (route) => false,
        arguments: UserRole.homeowner,
      ),
    );
  }

  void _goToRegister() {
    Navigator.of(context).pushNamed(AppRoutes.roleSelection);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
        child: Column(
          children: [
            const AuthHeader(
              title: 'تسجيل الدخول',
              subtitle: 'مرحبًا بعودتك، سجّل دخولك للمتابعة',
            ),
            SizedBox(height: 32.h),
            Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _emailController,
                      hint: 'البريد الإلكتروني',
                      icon: SolarIconsOutline.letter,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      validator: AuthValidators.email,
                    ),
                    SizedBox(height: 16.h),
                    AuthTextField(
                      controller: _passwordController,
                      hint: 'كلمة المرور',
                      icon: SolarIconsOutline.lockPassword,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      onSubmitted: (_) => _submit(),
                      validator: AuthValidators.loginPassword,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text('هل نسيت كلمة المرور؟', style: AppTextStyles.link),
              ),
            ),
            SizedBox(height: 28.h),
            AppButton(
              text: 'تسجيل الدخول',
              onPressed: _submit,
              borderRadius: 30,
              height: 58,
              icon: const Icon(SolarIconsOutline.arrowRight),
              showShine: true,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            SizedBox(height: 28.h),
            const SocialAuthSection(),
            SizedBox(height: 28.h),
            AuthSwitchPrompt(
              prompt: 'ليس لديك حساب؟',
              action: 'إنشاء حساب',
              onTap: _goToRegister,
            ),
          ],
        ),
      ),
    );
  }
}
