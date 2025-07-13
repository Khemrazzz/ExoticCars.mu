import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/auth_service.dart';
import '../../core/widgets/input_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/utils/validators.dart';
import '../../core/constants/color_scheme.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEmailLogin = true;

  final TextEditingController _contact = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> login() async {
    try {
      final response = _isEmailLogin
          ? await AuthService.signInWithEmail(
              _contact.text.trim(),
              _password.text.trim(),
            )
          : await AuthService.signInWithPhone(
              _contact.text.trim(),
              _password.text.trim(),
            );
      if (!mounted) return;

      if (response.user != null) {
        context.go('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                SwitchListTile(
                  title: const Text("Login using Email / Phone",
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                    _isEmailLogin ? "Email" : "Phone",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  value: _isEmailLogin,
                  onChanged: (val) => setState(() => _isEmailLogin = val),
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: _contact,
                  label: _isEmailLogin ? 'Email' : 'Phone Number',
                  keyboardType: _isEmailLogin
                      ? TextInputType.emailAddress
                      : TextInputType.phone,
                  validator: Validators.requiredField,
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: _password,
                  label: 'Password',
                  obscure: true,
                  validator: Validators.requiredField,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('/forgot'),
                    child: const Text('Forgot Password?',
                        style: TextStyle(color: Colors.amber)),
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: 'Log In',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) login();
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/register'),
                    child: const Text("Don't have an account? Sign Up",
                        style: TextStyle(color: Colors.amber)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
