import 'package:firebase_test/features/auth/domain/entities/login_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageServiceProvider = Provider<LocalStorageService>(
  (_) => LocalStorageServiceImpl(
    SharedPreferences.getInstance(),
  ),
);

abstract class LocalStorageService {
  Future<void> deleteAll();

  Future<void> setLoginType(LoginType token);

  Future<String?> getLoginType();
}

class LocalStorageServiceImpl implements LocalStorageService {
  final Future<SharedPreferences> _sharedPreferencesFuture;
  SharedPreferences? _sharedPreferencesInstance;

  LocalStorageServiceImpl(
    this._sharedPreferencesFuture,
  );

  Future<SharedPreferences> get _sharedPrefs async {
    return _sharedPreferencesInstance ??= await _sharedPreferencesFuture;
  }

  @override
  Future<void> deleteAll() async {
    await Future.wait([
      _deleteAllSharedPrefs(),
    ]);
  }

  @override
  Future<void> setLoginType(LoginType loginType) => _write(
        key: LocalStorageKey.loginType,
        value: loginType.name,
      );

  @override
  Future<String?> getLoginType() async {
    final loginType = await _read(LocalStorageKey.loginType);
    if (loginType != null) {
      return loginType;
    }
    return null;
  }

  Future<T?> _read<T>(LocalStorageKey key) async =>
      (await _sharedPrefs).get(key.key) as T?;

  Future<void> _write({
    required LocalStorageKey key,
    required String value,
  }) async {
    (await _sharedPrefs).setString(key.key, value);
  }

  Future<void> _deleteAllSharedPrefs() async => (await _sharedPrefs).clear();
}

enum LocalStorageKey {
  loginType('loginType');

  final String key;
  const LocalStorageKey(this.key);
}
