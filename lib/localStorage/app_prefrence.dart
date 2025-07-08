// lib/utils/app_preferences.dart

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _keyToken = 'firebase_token';
  // static const String _keyEmail = 'user_email';
  // static const String _keyUid = 'user_uid';

  /// Save token
  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  /// Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  // /// Save email
  // static Future<void> setEmail(String email) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_keyEmail, email);
  // }

  // /// Get email
  // static Future<String?> getEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_keyEmail);
  // }

  // /// Save UID
  // static Future<void> setUid(String uid) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_keyUid, uid);
  // }

  // /// Get UID
  // static Future<String?> getUid() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_keyUid);
  // }

  // /// Clear all data (use on logout)
  // static Future<void> clearAll() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  // }
}
