class Validators {
  static String? requiredField(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'Required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$');
    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }
}
