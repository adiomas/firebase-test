import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/features/auth/domain/entities/login_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginServiceProvider =
    Provider<LoginService>((ref) => LoginServiceImpl());

abstract class LoginService {
  Future<User?> loginWithFirebase({
    required String email,
    required String password,
  });
  Future<User?> getCurrentlySignedInUser({required String loginType});
  Future<void> logout();
}

class LoginServiceImpl extends LoginService {
  @override
  Future<User?> loginWithFirebase(
      {required String email, required String password}) async {
    final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user;
  }

  @override
  Future<User?> getCurrentlySignedInUser({required String loginType}) {
    if (LoginType.firebase.name == loginType) {
      return Future.value(FirebaseAuth.instance.currentUser);
    }
    return Future.value(null);
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
