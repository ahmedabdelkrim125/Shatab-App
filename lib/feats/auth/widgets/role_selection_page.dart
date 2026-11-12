import 'package:flutter/material.dart';
import 'package:shatab/core/routing/app_routes.dart';
import 'package:shatab/core/theme/app_theme.dart';
import 'package:shatab/core/utils/responsive_extension.dart';
import 'package:shatab/core/widgets/app_button.dart';
import 'package:shatab/feats/auth/models/user_role.dart';
import 'package:solar_icons/solar_icons.dart';

import 'auth_header.dart';
import 'auth_scaffold.dart';
import 'auth_switch_prompt.dart';
import 'role_card.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  UserRole? _selected;

  void _continue() {
    final role = _selected;
    if (role == null) return;
    Navigator.of(context).pushNamed(AppRoutes.register, arguments: role);
  }

  void _goToLogin() {
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(
              title: 'اختر نوع حسابك',
              subtitle: 'حدد دورك لنجهز لك التجربة المناسبة',
            ),
            SizedBox(height: 32.h),
            for (final role in UserRole.values) ...[
              RoleCard(
                role: role,
                selected: _selected == role,
                onTap: () => setState(() => _selected = role),
              ),
              SizedBox(height: 16.h),
            ],
            SizedBox(height: 16.h),
            AppButton(
              text: 'متابعة',
              onPressed: _selected == null ? null : _continue,
              isEnabled: _selected != null,
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
    );
  }
}
