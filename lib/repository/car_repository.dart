import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_config.dart';
import '../models/car_model.dart';

class CarRepository {
  final SupabaseClient _client = SupabaseConfig.client;
  final String _table = 'cars';

  Future<List<CarModel>> fetchAll() async {
    final List<dynamic> data = await _client.from(_table).select();
    return data.map((e) => CarModel.fromMap(e)).toList();
  }

  Future<CarModel?> fetchById(String id) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();
    if (data == null) return null;
    return CarModel.fromMap(data);
  }

  Future<CarModel> create(CarModel car) async {
    final data = await _client
        .from(_table)
        .insert(car.toMap())
        .select()
        .single();
    return CarModel.fromMap(data);
  }

  Future<CarModel> update(CarModel car) async {
    final data = await _client
        .from(_table)
        .update(car.toMap())
        .eq('id', car.id)
        .select()
        .single();
    return CarModel.fromMap(data);
  }

  Future<void> delete(String id) async {
    await _client.from(_table).delete().eq('id', id);
  }
}
