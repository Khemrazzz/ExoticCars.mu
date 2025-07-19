
import 'package:functions_client/functions_client.dart';

import '../../config/supabase_config.dart';

class QuoteService {
  static Future<FunctionResponse> requestQuote(
    String email,
    String carName,
  ) async {
    final response = await SupabaseConfig.client.functions.invoke(
      'send_quote',
      body: {'email': email, 'car_name': carName},
    );

    if (response.status == null || response.status! >= 400) {
      throw Exception('Quote request failed: ${response.data}');
    }

    return response;
  }
}
