import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/common/data/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

final loginServiceProvider = Provider<LoginService>((ref) => LoginServiceImpl(
      ref.watch(supabaseProvider),
    ));

abstract class LoginService {
  Future<User?> loginWithFirebase({
    required String email,
    required String password,
  });
  Future<supabase.User?> loginWithSupabase({
    required String email,
    required String password,
  });
  User? getCurrentlySignedInUserFromFirebase();
  supabase.User? getCurrentlySignedInUserFromSupabase();
  Future<void> logoutFromFirebase();
  Future<void> logoutFromSupabase();
}

class LoginServiceImpl extends LoginService {
  final supabase.SupabaseClient _supabaseClient;

  LoginServiceImpl(this._supabaseClient);

  @override
  Future<User?> loginWithFirebase({
    required String email,
    required String password,
  }) async {
    final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user;
  }

  @override
  Future<supabase.User?> loginWithSupabase({
    required String email,
    required String password,
  }) async {
    final supabase.AuthResponse response =
        await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.session?.user;
  }

  @override
  User? getCurrentlySignedInUserFromFirebase() =>
      FirebaseAuth.instance.currentUser;

  @override
  supabase.User? getCurrentlySignedInUserFromSupabase() =>
      _supabaseClient.auth.currentUser;

  @override
  Future<void> logoutFromFirebase() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> logoutFromSupabase() async {
    await _supabaseClient.auth.signOut();
  }
}
