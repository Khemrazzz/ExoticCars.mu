import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    if (session == null) {
      return const LoginScreen(); // Not logged in
    } else if (!(session.user?.emailConfirmedAt != null ||
        session.user?.phone != null)) {
      return const Center(child: Text('Please verify your account.'));
    } else {
      return const HomeScreen(); // Already logged in + verified
    }
  }
}
