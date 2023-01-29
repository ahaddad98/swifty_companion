import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static SharedPreferences? _prefs;

  static Future<bool> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs != null;
  }

  // keys
  static const String _kDarkMode = 'darkMode';
  static const String _accessToken = 'accessToken';
  static const String _refreshToken = 'refreshToken';

  // app settings
  // dark mode
  static Future<bool> storeDarkMode({required bool isDarkMode}) async =>
      _prefs!.setBool(_kDarkMode, isDarkMode);
  static Future<bool?> getDarkMode() async => _prefs!.getBool(_kDarkMode);
  static Future<bool> removeDarkMode() async => _prefs!.remove(_kDarkMode);
  // accessToken
  static Future<bool> storeAccessToken({required String accessToken}) async =>
      _prefs!.setString(_accessToken, accessToken);
  static Future<String?> getAccessToken() async =>
      _prefs!.getString(_accessToken);
  static Future<bool> removeAccessToken() async => _prefs!.remove(_accessToken);
  // RefreshToken
  static Future<bool> storeRefreshToken({required String refreshToken}) async =>
      _prefs!.setString(_refreshToken, refreshToken);
  static Future<String?> getRefreshToken() async =>
      _prefs!.getString(_refreshToken);
  static Future<bool> removeRefreshToken() async =>
      _prefs!.remove(_refreshToken);
}
