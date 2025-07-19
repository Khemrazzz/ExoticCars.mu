import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  /// Uploads the given [file] to the `car-images` bucket and returns
  /// the publicly accessible URL for the uploaded file. Returns `null`
  /// if the upload fails.
  static Future<String?> uploadCarImage(File file) async {
    final supabase = Supabase.instance.client;
    final fileName = 'car_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final response = await supabase.storage
        .from('car-images')
        .upload(fileName, file);

    if (response.isEmpty) {
      return null;
    }

    final publicUrl = supabase.storage
        .from('car-images')
        .getPublicUrl(fileName);
    return publicUrl;
  }
}
