
import '../../config/supabase_config.dart';

class QuoteService {
  static Future<void> requestQuote(String email, String carName) {
    return SupabaseConfig.client.functions.invoke(
      'send_quote',
      body: {'email': email, 'car_name': carName},
    );
  }
}
