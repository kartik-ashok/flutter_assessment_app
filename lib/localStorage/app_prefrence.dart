import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _keyToken = 'firebase_token';
  static const String _keyEmail = 'user_email';
  static const String _keyUid = 'user_uid';

  static Future<void> setToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString(_keyToken, token); // ✅ token is non-null here
    } else {
      await prefs.remove(_keyToken);
    }
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<void> setEmail(String? email) async {
    final prefs = await SharedPreferences.getInstance();
    if (email != null) {
      await prefs.setString(_keyEmail, email);
    } else {
      await prefs.remove(_keyEmail);
    }
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  static Future<void> setUid(String? uid) async {
    final prefs = await SharedPreferences.getInstance();
    if (uid != null) {
      await prefs.setString(_keyUid, uid);
    } else {
      await prefs.remove(_keyUid);
    }
  }

  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUid);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
