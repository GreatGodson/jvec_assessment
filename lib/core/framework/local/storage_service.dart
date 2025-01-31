import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jvec_test/core/framework/local/storage_keys.dart';

class AppPreferences {
  static late FlutterSecureStorage _secureStorage;

  static String? _signupCredentials;
  static String? _rideList;

  factory AppPreferences() => AppPreferences._internal();

  AppPreferences._internal();

  static Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
    _signupCredentials =
        await _secureStorage.read(key: PrefsConstants.signupCredentials);

    _rideList = await _secureStorage.read(key: PrefsConstants.rideList);
  }

  static Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  static Future<void> clearKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  static String get signupCredentials => _signupCredentials ?? "";

  static String get rideList => _rideList ?? "";

  static Future<void> storeSignupCredentials(String value) async {
    _signupCredentials = value;
    await _secureStorage.write(
        key: PrefsConstants.signupCredentials, value: value);
  }

  static Future<void> storeRideList(String value) async {
    _rideList = value;
    await _secureStorage.write(key: PrefsConstants.rideList, value: value);
  }
}
