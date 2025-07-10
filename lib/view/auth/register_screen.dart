import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../config/supabase_config.dart';
import 'login_screen.dart';
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
        await client.auth.signUp(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
      } else {
        await client.auth.signUp(
          phone: _phone.text.trim(),
          password: _password.text.trim(),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Registration successful. Please check your ${_isEmailMode ? 'email' : 'phone'} to confirm your account.',
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyEmailScreen(
            email: _email.text.trim(),
            password: _password.text.trim(),
          ),
        ),
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
      backgroundColor: Colors.black,
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
                    ? _buildInput(_email, 'Email',
                    keyboardType: TextInputType.emailAddress)
                    : _buildInput(_phone, 'Phone Number (+230...)',
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 16),
                _buildInput(_password, 'Password', obscure: true),
                const SizedBox(height: 16),
                _buildInput(_firstName, 'First Name'),
                const SizedBox(height: 16),
                _buildInput(_lastName, 'Last Name'),
                const SizedBox(height: 16),
                _buildInput(_nic, 'NIC'),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Are you currently in Mauritius?',
                      style: TextStyle(color: Colors.white)),
                  value: _isMauritianResident,
                  onChanged: (val) =>
                      setState(() => _isMauritianResident = val),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) registerUser();
                    },
                    child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
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

  Widget _buildInput(TextEditingController controller, String label,
      {bool obscure = false, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) =>
      value == null || value.trim().isEmpty ? 'Required' : null,
    );
  }
}
