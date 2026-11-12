class AuthValidators {
  AuthValidators._();

  static final RegExp _email = RegExp(
    r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$',
  );
  static final RegExp _digit = RegExp(r'[0-9٠-٩]');
  static final RegExp _letter = RegExp(r'\p{L}', unicode: true);
  static final RegExp _egyptPhone = RegExp(r'^(\+20|0020|0)?1[0125][0-9]{8}$');

  static String _latinDigits(String input) {
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    var out = input;
    for (var i = 0; i < arabic.length; i++) {
      out = out.replaceAll(arabic[i], '$i');
    }
    return out;
  }

  static String? fullName(String? input) {
    final value = (input ?? '').trim();
    if (value.isEmpty) return 'من فضلك أدخل الاسم الكامل';
    if (_digit.hasMatch(value)) return 'الاسم لا يجب أن يحتوي على أرقام';
    final parts = value.split(RegExp(r'\s+')).where((e) => e.length >= 2);
    if (parts.length < 2) return 'أدخل الاسم الأول والأخير على الأقل';
    return null;
  }

  static String? email(String? input) {
    final value = (input ?? '').trim();
    if (value.isEmpty) return 'من فضلك أدخل البريد الإلكتروني';
    if (!_email.hasMatch(value)) return 'البريد الإلكتروني غير صالح';
    return null;
  }

  static String? phone(String? input) {
    final value = _latinDigits(
      (input ?? '').trim(),
    ).replaceAll(RegExp(r'[\s\-]'), '');
    if (value.isEmpty) return 'من فضلك أدخل رقم الموبايل';
    if (!_egyptPhone.hasMatch(value)) {
      return 'رقم الموبايل غير صالح، مثال: 01012345678';
    }
    return null;
  }

  static String? loginPassword(String? input) {
    final value = input ?? '';
    if (value.isEmpty) return 'من فضلك أدخل كلمة المرور';
    if (value.length < 8) return 'كلمة المرور يجب ألا تقل عن 8 أحرف';
    return null;
  }

  static String? newPassword(String? input) {
    final value = input ?? '';
    if (value.isEmpty) return 'من فضلك أدخل كلمة المرور';
    if (value.length < 8) return 'كلمة المرور يجب ألا تقل عن 8 أحرف';
    if (!_letter.hasMatch(value) || !_digit.hasMatch(value)) {
      return 'كلمة المرور يجب أن تحتوي على حروف وأرقام';
    }
    return null;
  }

  static String? confirmPassword(String? input, String password) {
    final value = input ?? '';
    if (value.isEmpty) return 'من فضلك أكد كلمة المرور';
    if (value != password) return 'كلمتا المرور غير متطابقتين';
    return null;
  }

  static String? requiredSelection(List<String>? value, String message) {
    if (value == null || value.isEmpty) return message;
    return null;
  }

  static String? optionalCompanyName(String? input) {
    final value = (input ?? '').trim();
    if (value.isEmpty) return null;
    if (value.length < 3) return 'اسم الشركة قصير جدًا';
    return null;
  }

  static String? optionalBio(String? input) {
    final value = (input ?? '').trim();
    if (value.isEmpty) return null;
    if (value.length < 20) {
      return 'اكتب 20 حرفًا على الأقل أو اترك الحقل فارغًا';
    }
    return null;
  }
}
