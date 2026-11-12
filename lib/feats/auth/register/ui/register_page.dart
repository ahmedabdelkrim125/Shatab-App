import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shatab/core/routing/app_routes.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/core/widgets/app_button.dart';
import 'package:shatab/feats/auth/models/auth_options.dart';
import 'package:shatab/feats/auth/models/user_role.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../../../core/utils/auth_validators.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/auth_scaffold.dart';
import '../../widgets/auth_select_field.dart';
import '../../widgets/auth_styles.dart';
import '../../widgets/auth_success_dialog.dart';
import '../../widgets/auth_switch_prompt.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/portfolio_picker.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/terms_checkbox.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.role});

  final UserRole role;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  late final List<GlobalKey<FormState>> _formKeys;

  int _step = 0;
  List<String> _governorate = const [];
  List<String> _specialties = const [];
  List<String> _experience = const [];
  List<String> _workAreas = const [];
  List<XFile> _portfolio = const [];
  bool _acceptedTerms = false;

  bool get _isProvider => widget.role == UserRole.provider;

  List<String> get _stepTitles => _isProvider
      ? const ['بيانات الحساب', 'بيانات المهنة', 'أعمالك السابقة']
      : const ['بيانات الحساب'];

  bool get _isLastStep => _step == _stepTitles.length - 1;

  @override
  void initState() {
    super.initState();
    _formKeys = List.generate(
      _stepTitles.length,
      (_) => GlobalKey<FormState>(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _companyController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    setState(() => _step = step);
    if (_scrollController.hasClients) _scrollController.jumpTo(0);
  }

  void _back() {
    FocusScope.of(context).unfocus();
    if (_step > 0) {
      _goToStep(_step - 1);
      return;
    }
    Navigator.of(context).maybePop();
  }

  void _next() {
    FocusScope.of(context).unfocus();
    if (!_formKeys[_step].currentState!.validate()) return;
    if (_isLastStep) {
      _submit();
      return;
    }
    _goToStep(_step + 1);
  }

  void _submit() {
    showAuthSuccessDialog(
      context: context,
      title: 'تم إنشاء حسابك بنجاح',
      message: _isProvider
          ? 'أهلاً بك في شطب، ملفك المهني جاهز لاستقبال العملاء'
          : 'أهلاً بك في شطب، يمكنك الآن البدء في مشروعك',
    );
  }

  void _goToLogin() {
    Navigator.of(context).popUntil(
      (route) => route.isFirst || route.settings.name == AppRoutes.login,
    );
  }

  List<Widget> _spaced(List<Widget> children) {
    return [
      for (var i = 0; i < children.length; i++) ...[
        if (i > 0) SizedBox(height: 16.h),
        children[i],
      ],
    ];
  }

  Widget _accountStep() {
    return Form(
      key: _formKeys[0],
      child: AutofillGroup(
        child: Column(
          children: _spaced([
            AuthTextField(
              controller: _nameController,
              hint: 'الاسم الكامل',
              icon: SolarIconsOutline.user,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              validator: AuthValidators.fullName,
            ),
            AuthTextField(
              controller: _emailController,
              hint: 'البريد الإلكتروني',
              icon: SolarIconsOutline.letter,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              validator: AuthValidators.email,
            ),
            AuthTextField(
              controller: _phoneController,
              hint: 'رقم الموبايل',
              icon: SolarIconsOutline.phone,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.telephoneNumber],
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩+]')),
                LengthLimitingTextInputFormatter(14),
              ],
              validator: AuthValidators.phone,
            ),
            if (!_isProvider)
              AuthSelectField(
                hint: 'المحافظة',
                sheetTitle: 'اختر المحافظة',
                icon: SolarIconsOutline.mapPoint,
                options: AuthOptions.governorates,
                initialValue: _governorate,
                onChanged: (value) => _governorate = value,
                validator: (value) =>
                    AuthValidators.requiredSelection(value, 'من فضلك اختر المحافظة'),
              ),
            AuthTextField(
              controller: _passwordController,
              hint: 'كلمة المرور',
              icon: SolarIconsOutline.lockPassword,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              validator: AuthValidators.newPassword,
            ),
            AuthTextField(
              controller: _confirmController,
              hint: 'تأكيد كلمة المرور',
              icon: SolarIconsOutline.lockPassword,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _next(),
              validator: (value) => AuthValidators.confirmPassword(
                value,
                _passwordController.text,
              ),
            ),
            if (!_isProvider)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: TermsCheckbox(
                  initialValue: _acceptedTerms,
                  onChanged: (value) => _acceptedTerms = value,
                ),
              ),
          ]),
        ),
      ),
    );
  }

  Widget _professionStep() {
    return Form(
      key: _formKeys[1],
      child: Column(
        children: _spaced([
          AuthSelectField(
            hint: 'التخصص (حتى ${AuthOptions.maxSpecialties})',
            sheetTitle: 'اختر تخصصك',
            icon: SolarIconsOutline.suitcase,
            options: AuthOptions.specialties,
            multi: true,
            maxSelection: AuthOptions.maxSpecialties,
            initialValue: _specialties,
            onChanged: (value) => _specialties = value,
            validator: (value) =>
                AuthValidators.requiredSelection(value, 'من فضلك اختر تخصصك'),
          ),
          AuthSelectField(
            hint: 'سنوات الخبرة',
            sheetTitle: 'سنوات الخبرة',
            icon: SolarIconsOutline.medalRibbon,
            options: AuthOptions.experienceLevels,
            initialValue: _experience,
            onChanged: (value) => _experience = value,
            validator: (value) => AuthValidators.requiredSelection(
              value,
              'من فضلك اختر سنوات خبرتك',
            ),
          ),
          AuthSelectField(
            hint: 'المحافظات التي تعمل بها',
            sheetTitle: 'اختر المحافظات',
            icon: SolarIconsOutline.mapPoint,
            options: AuthOptions.governorates,
            multi: true,
            initialValue: _workAreas,
            onChanged: (value) => _workAreas = value,
            validator: (value) => AuthValidators.requiredSelection(
              value,
              'اختر محافظة واحدة على الأقل',
            ),
          ),
          AuthTextField(
            controller: _companyController,
            hint: 'اسم الشركة (اختياري)',
            icon: SolarIconsOutline.buildings,
            textInputAction: TextInputAction.next,
            validator: AuthValidators.optionalCompanyName,
          ),
          AuthTextField(
            controller: _bioController,
            hint: 'نبذة عن خبراتك وأعمالك (اختياري)',
            icon: SolarIconsOutline.notes,
            maxLines: 4,
            maxLength: 300,
            textInputAction: TextInputAction.newline,
            validator: AuthValidators.optionalBio,
          ),
        ]),
      ),
    );
  }

  Widget _portfolioStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أضف صورًا حقيقية من مشاريع نفذتها، فهي أول ما يبحث عنه العملاء قبل التواصل معك. يمكنك تخطي هذه الخطوة وإضافتها لاحقًا.',
          style: AuthStyles.subtitle,
        ),
        SizedBox(height: 20.h),
        PortfolioPicker(
          images: _portfolio,
          maxImages: AuthOptions.maxPortfolioImages,
          onChanged: (value) {
            if (!mounted) return;
            setState(() => _portfolio = value);
          },
        ),
        SizedBox(height: 24.h),
        Form(
          key: _formKeys[2],
          child: TermsCheckbox(
            initialValue: _acceptedTerms,
            onChanged: (value) => _acceptedTerms = value,
          ),
        ),
      ],
    );
  }

  Widget _buildStep() {
    if (!_isProvider) return _accountStep();
    switch (_step) {
      case 0:
        return _accountStep();
      case 1:
        return _professionStep();
      default:
        return _portfolioStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _back();
      },
      child: AuthScaffold(
        child: SingleChildScrollView(
          controller: _scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthHeader(
                title: _isProvider ? 'حساب مقدم خدمة' : 'إنشاء حساب',
                subtitle: _isProvider
                    ? 'أنشئ ملفك المهني ودع العملاء يتعرفون على أعمالك'
                    : 'أنشئ حسابك كصاحب منزل وابدأ مشروعك الآن',
                onBack: _back,
              ),
              SizedBox(height: _isProvider ? 24.h : 32.h),
              if (_isProvider) ...[
                StepIndicator(current: _step, titles: _stepTitles),
                SizedBox(height: 24.h),
              ],
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: KeyedSubtree(
                  key: ValueKey<int>(_step),
                  child: _buildStep(),
                ),
              ),
              SizedBox(height: 28.h),
              AppButton(
                text: _isLastStep ? 'إنشاء حساب' : 'التالي',
                onPressed: _next,
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
              AuthSwitchPrompt(
                prompt: 'لديك حساب بالفعل؟',
                action: 'تسجيل الدخول',
                onTap: _goToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
