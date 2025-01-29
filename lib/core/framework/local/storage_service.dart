import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jvec_test/core/framework/local/storage_keys.dart';

class AppPreferences {
  static late FlutterSecureStorage _secureStorage;

  static String? _signupCredentials;

  factory AppPreferences() => AppPreferences._internal();

  AppPreferences._internal();

  static Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
    _signupCredentials =
        await _secureStorage.read(key: PrefsConstants.signupCredentials);
  }

  static Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  static Future<void> clearKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  static String get signupCredentials => _signupCredentials ?? "";

  static Future<void> storeSignupCredentials(String value) async {
    _signupCredentials = value;
    await _secureStorage.write(
        key: PrefsConstants.signupCredentials, value: value);
  }
}
