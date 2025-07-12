import 'package:flutter/material.dart';
import '../constants/color_scheme.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const InputField({
    required this.controller,
    required this.label,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(labelText: label),
      validator: validator,
    );
  }
}
