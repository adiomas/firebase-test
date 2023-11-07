import 'package:firebase_test/features/auth/domain/entities/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final authFormMapperProvider = Provider<FormMapper<Auth>>(
  (_) => AuthForm.authFromJson,
);

abstract class AuthForm {
  static const emailKey = 'email';
  static const passwordKey = 'password';

  static Auth authFromJson(Map<String, dynamic> formMap) => Auth(
        email: formMap[emailKey],
        password: formMap[passwordKey],
      );
}
