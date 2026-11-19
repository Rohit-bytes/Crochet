import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  Future<void> login(String email, String password) async {
    await _client.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await _client.auth.signUp(
      email: email.trim(),
      password: password,
      data: {'name': name.trim()},
    );
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
