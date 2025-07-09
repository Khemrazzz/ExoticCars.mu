import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../config/supabase_config.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEmailSelected = true;

  final TextEditingController _contact = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _nic = TextEditingController();
  bool _isMauritianResident = true;

  Future<void> registerUser() async {
    final client = SupabaseConfig.client;

    try {
      final response = _isEmailSelected
          ? await client.auth.signUp(
        email: _contact.text.trim(),
        password: _password.text.trim(),
      )
          : await client.auth.signUp(
        phone: _contact.text.trim(),
        password: _password.text.trim(),
      );

      // Show registration success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEmailSelected
              ? 'Registration successful. Please check your email to confirm your account.'
              : 'Registration successful. Please verify the OTP sent to your phone.'),
        ),
      );

      // Redirect to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
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
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SwitchListTile(
                title: const Text("Register with Email / Phone"),
                subtitle:
                Text(_isEmailSelected ? "Using Email" : "Using Phone"),
                value: _isEmailSelected,
                onChanged: (val) => setState(() => _isEmailSelected = val),
              ),
              TextFormField(
                controller: _contact,
                decoration: InputDecoration(
                  labelText: _isEmailSelected
                      ? 'Email Address'
                      : 'Phone Number (+230...)',
                ),
                keyboardType: _isEmailSelected
                    ? TextInputType.emailAddress
                    : TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }

                  if (_isEmailSelected) {
                    final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Enter a valid email';
                    }
                  } else {
                    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
                    if (!phoneRegex.hasMatch(value.trim())) {
                      return 'Enter a valid phone number';
                    }
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _firstName,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: _lastName,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                controller: _nic,
                decoration: const InputDecoration(labelText: 'NIC'),
              ),
              SwitchListTile(
                title: const Text('Are you currently in Mauritius?'),
                value: _isMauritianResident,
                onChanged: (val) =>
                    setState(() => _isMauritianResident = val),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) registerUser();
                },
                child: const Text('Register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
