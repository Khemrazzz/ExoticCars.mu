import 'package:flutter/material.dart';
import '../constants/color_scheme.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  const PrimaryButton({
    required this.text,
    this.onPressed,
    this.loading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        child: loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.background,
                  strokeWidth: 2,
                ),
              )
            : Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
