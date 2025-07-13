import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/auth_service.dart';
import '../../core/widgets/input_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/utils/validators.dart';
import '../../core/constants/color_scheme.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  bool _loading = false;

  Future<void> _updatePassword() async {
    setState(() => _loading = true);
    try {
      await AuthService.updatePassword(_password.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated. Please log in.')),
        );
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputField(
                controller: _password,
                label: 'New Password',
                obscure: true,
                validator: Validators.requiredField,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _confirm,
                label: 'Confirm Password',
                obscure: true,
                validator: (val) {
                  if (val != _password.text) return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Update Password',
                loading: _loading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updatePassword();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
