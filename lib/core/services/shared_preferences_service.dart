import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

/// Service for managing shared preferences
class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesService._internal();

  static SharedPreferencesService get instance {
    _instance ??= SharedPreferencesService._internal();
    return _instance!;
  }

  /// Initialize shared preferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Get SharedPreferences instance
  SharedPreferences get preferences {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _preferences!;
  }

  // Theme Management
  Future<void> setThemeMode(String themeMode) async {
    await preferences.setString(AppConstants.themeKey, themeMode);
  }

  String getThemeMode() {
    return preferences.getString(AppConstants.themeKey) ?? 'system';
  }

  // Language Management
  Future<void> setLanguageCode(String languageCode) async {
    await preferences.setString(AppConstants.languageKey, languageCode);
  }

  String getLanguageCode() {
    return preferences.getString(AppConstants.languageKey) ?? 'en';
  }

  // User Token Management
  Future<void> setUserToken(String token) async {
    await preferences.setString(AppConstants.userTokenKey, token);
  }

  String? getUserToken() {
    return preferences.getString(AppConstants.userTokenKey);
  }

  Future<void> removeUserToken() async {
    await preferences.remove(AppConstants.userTokenKey);
  }

  // User Data Management
  Future<void> setUserData(Map<String, dynamic> userData) async {
    final userDataString = jsonEncode(userData);
    await preferences.setString(AppConstants.userDataKey, userDataString);
  }

  Map<String, dynamic>? getUserData() {
    final userDataString = preferences.getString(AppConstants.userDataKey);
    if (userDataString != null) {
      return jsonDecode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> removeUserData() async {
    await preferences.remove(AppConstants.userDataKey);
  }

  // First Time User Check
  Future<void> setFirstTime(bool isFirstTime) async {
    await preferences.setBool(AppConstants.isFirstTimeKey, isFirstTime);
  }

  bool isFirstTime() {
    return preferences.getBool(AppConstants.isFirstTimeKey) ?? true;
  }

  // Generic Methods
  Future<void> setString(String key, String value) async {
    await preferences.setString(key, value);
  }

  String? getString(String key) {
    return preferences.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return preferences.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await preferences.setInt(key, value);
  }

  int? getInt(String key) {
    return preferences.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    await preferences.setDouble(key, value);
  }

  double? getDouble(String key) {
    return preferences.getDouble(key);
  }

  Future<void> remove(String key) async {
    await preferences.remove(key);
  }

  Future<void> clear() async {
    await preferences.clear();
  }

  bool containsKey(String key) {
    return preferences.containsKey(key);
  }

  Set<String> getKeys() {
    return preferences.getKeys();
  }
}
