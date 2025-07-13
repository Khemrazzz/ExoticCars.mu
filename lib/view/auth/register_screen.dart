import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/auth_service.dart';
import '../../core/widgets/input_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/utils/validators.dart';
import '../../core/constants/color_scheme.dart';
import '../../../config/supabase_config.dart';
import 'verify_email_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _nic = TextEditingController();
  bool _isMauritianResident = true;
  bool _isEmailMode = true;

  Future<void> registerUser() async {
    final client = SupabaseConfig.client;

    try {
      if (_isEmailMode) {
        await AuthService.signUpWithEmail(
          _email.text.trim(),
          _password.text.trim(),
        );
      } else {
        await AuthService.signUpWithPhone(
          _phone.text.trim(),
          _password.text.trim(),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Registration successful. Please check your ${_isEmailMode ? 'email' : 'phone'} to confirm your account.',
          ),
        ),
      );

      context.go(
        '/verify',
        extra: {
          'email': _email.text.trim(),
          'password': _password.text.trim(),
        },
      );
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Create an account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                SwitchListTile(
                  title: const Text('Register using Email / Phone',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(_isEmailMode ? 'Email' : 'Phone',
                      style: const TextStyle(color: Colors.white70)),
                  value: _isEmailMode,
                  onChanged: (val) => setState(() => _isEmailMode = val),
                ),
                const SizedBox(height: 16),
                _isEmailMode
                    ? InputField(
                        controller: _email,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.requiredField,
                      )
                    : InputField(
                        controller: _phone,
                        label: 'Phone Number (+230...)',
                        keyboardType: TextInputType.phone,
                        validator: Validators.requiredField,
                      ),
                const SizedBox(height: 16),
                InputField(
                  controller: _password,
                  label: 'Password',
                  obscure: true,
                  validator: Validators.requiredField,
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: _firstName,
                  label: 'First Name',
                  validator: Validators.requiredField,
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: _lastName,
                  label: 'Last Name',
                  validator: Validators.requiredField,
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: _nic,
                  label: 'NIC',
                  validator: Validators.requiredField,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Are you currently in Mauritius?',
                      style: TextStyle(color: Colors.white)),
                  value: _isMauritianResident,
                  onChanged: (val) =>
                      setState(() => _isMauritianResident = val),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'Sign Up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) registerUser();
                  },
                ),
                const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text(
                        'Already have an account? Log In',
                        style: TextStyle(color: Colors.amber),
                      ),
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
