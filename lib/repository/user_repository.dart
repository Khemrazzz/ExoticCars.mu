import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_config.dart';
import '../models/user_profile.dart';

class UserRepository {
  final SupabaseClient _client = SupabaseConfig.client;
  final String _table = 'profiles';

  Future<UserProfile> create(UserProfile profile) async {
    final data = await _client
        .from(_table)
        .insert(profile.toMap())
        .select()
        .single();
    return UserProfile.fromMap(data);
  }

  Future<UserProfile?> fetchById(String id) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();
    if (data == null) return null;
    return UserProfile.fromMap(data);
  }

  Future<List<UserProfile>> fetchAll() async {
    final List<dynamic> data = await _client.from(_table).select();
    return data.map((e) => UserProfile.fromMap(e)).toList();
  }

  Future<UserProfile> update(UserProfile profile) async {
    final data = await _client
        .from(_table)
        .update(profile.toMap())
        .eq('id', profile.id)
        .select()
        .single();
    return UserProfile.fromMap(data);
  }

  Future<void> delete(String id) async {
    await _client.from(_table).delete().eq('id', id);
  }
}
