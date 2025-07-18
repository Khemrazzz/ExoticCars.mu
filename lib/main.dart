import 'package:flutter/material.dart';
import 'config/env.dart';
import 'config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load(); // Loads .env

  AuthState? initialAuthState;
  await SupabaseConfig.initialize(
    onAuthStateChange: (data) => initialAuthState = data,
  );

  runApp(App(initialAuthState: initialAuthState));
}
