import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  static StreamSubscription<AuthState>? _authSubscription;

  static Future<void> initialize({
    void Function(AuthState data)? onAuthStateChange,
  }) async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
      authCallbackUrlHostname: 'login-callback',
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );

    if (onAuthStateChange != null) {
      _authSubscription?.cancel();
      _authSubscription =
          Supabase.instance.client.auth.onAuthStateChange.listen(onAuthStateChange);
    }
  }

  static void registerAuthListener(void Function(AuthState data) callback) {
    _authSubscription?.cancel();
    _authSubscription =
        Supabase.instance.client.auth.onAuthStateChange.listen(callback);
  }

  static SupabaseClient get client => Supabase.instance.client;
}
