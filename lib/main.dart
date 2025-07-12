import 'package:flutter/material.dart';
import 'config/env.dart';
import 'config/supabase_config.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load(); // Loads .env
  await SupabaseConfig.initialize(); // Initializes Supabase
  runApp(const App());
}
