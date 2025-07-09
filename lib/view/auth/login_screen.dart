import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../home/home_screen.dart';
import 'register_screen.dart';

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
          ? await Supabase.instance.client.auth.signInWithPassword(
        email: _contact.text.trim(),
        password: _password.text.trim(),
      )
          : await Supabase.instance.client.auth.signInWithPassword(
        phone: _contact.text.trim(),
        password: _password.text.trim(),
      );

      if (response.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SwitchListTile(
                title: const Text("Login using Email / Phone"),
                subtitle: Text(_isEmailLogin ? "Email" : "Phone"),
                value: _isEmailLogin,
                onChanged: (val) => setState(() => _isEmailLogin = val),
              ),
              TextFormField(
                controller: _contact,
                decoration: InputDecoration(
                  labelText: _isEmailLogin ? "Email" : "Phone Number",
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) login();
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text("Don't have an account? Register here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
