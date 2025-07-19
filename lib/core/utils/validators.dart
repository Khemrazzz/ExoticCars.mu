class Validators {
  // Checks if the field is not empty
  static String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Validates email format
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Validates phone format
  static String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^(?:\+230)?5\d{7}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }


  // Validates password length (at least 8 characters)
  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.trim().length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // Validates NIC
  static String? nicValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'NIC is required';
    }
    final nicRegex = RegExp(r'^[A-Za-z]\d{9}$');
    if (!nicRegex.hasMatch(value.trim())) {
      return 'Enter a valid NIC';
    }
    return null;
  }

}
