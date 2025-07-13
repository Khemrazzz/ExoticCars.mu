import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:exotic_cars_apk/core/constants.dart';

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
    return _client.auth.resetPasswordForEmail(
      email,
      redirectTo: kAuthRedirectUrl,
    );
  }

  static Future<void> updatePassword(String password) {
    return _client.auth.updateUser(UserAttributes(password: password));
  }

  static Future<void> signOut() {
    return _client.auth.signOut();
  }
}
