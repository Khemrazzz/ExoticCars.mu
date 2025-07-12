import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static SupabaseClient get _client => Supabase.instance.client;

  static Future<AuthResponse> signInWithEmail(String email, String password) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<AuthResponse> signInWithPhone(String phone, String password) {
    return _client.auth.signInWithPassword(phone: phone, password: password);
  }

  static Future<AuthResponse> signUpWithEmail(String email, String password) {
    return _client.auth.signUp(email: email, password: password);
  }

  static Future<AuthResponse> signUpWithPhone(String phone, String password) {
    return _client.auth.signUp(phone: phone, password: password);
  }

  static Future<void> resetPassword(String email) {
    return _client.auth.resetPasswordForEmail(email);
  }

  static Future<void> signOut() {
    return _client.auth.signOut();
  }
}
