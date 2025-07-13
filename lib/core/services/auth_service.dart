import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/env.dart';

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
      redirectTo: Env.authRedirectUrl,
    );
  }

  static Future<void> updatePassword(String password) {
    return _client.auth.updateUser(UserAttributes(password: password));
  }

  static Future<void> sendResetOtp(String email) {
    return _client.auth.resetPasswordForEmail(email);
  }

  static Future<AuthResponse> verifyResetOtp(String email, String token) {
    return _client.auth
        .verifyOTP(email: email, token: token, type: OtpType.recovery);
  }

  static Future<void> signOut() {
    return _client.auth.signOut();
  }
}
