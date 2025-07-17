import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreferences {
  static const String _keyNotificationsEnabled = 'notifications_enabled';
  static const String _keyPushNotificationsEnabled =
      'push_notifications_enabled';
  static const String _keyHealthRemindersEnabled = 'health_reminders_enabled';
  static const String _keyAppointmentRemindersEnabled =
      'appointment_reminders_enabled';
  static const String _keyFcmToken = 'fcm_token';

  /// Get local notification preference
  static Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNotificationsEnabled) ?? false;
  }

  /// Set local notification preference
  static Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotificationsEnabled, enabled);
  }

  /// Get push notification preference
  static Future<bool> getPushNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyPushNotificationsEnabled) ??
        true; // Default enabled
  }

  /// Set push notification preference
  static Future<void> setPushNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyPushNotificationsEnabled, enabled);
  }

  /// Get health reminders preference
  static Future<bool> getHealthRemindersEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHealthRemindersEnabled) ?? true;
  }

  /// Set health reminders preference
  static Future<void> setHealthRemindersEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHealthRemindersEnabled, enabled);
  }

  /// Get appointment reminders preference
  static Future<bool> getAppointmentRemindersEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAppointmentRemindersEnabled) ?? true;
  }

  /// Set appointment reminders preference
  static Future<void> setAppointmentRemindersEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAppointmentRemindersEnabled, enabled);
  }

  /// Store FCM token
  static Future<void> storeFcmToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFcmToken, token);
  }

  /// Get stored FCM token
  static Future<String?> getFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFcmToken);
  }

  /// Toggle local notification preference
  static Future<bool> toggleNotifications() async {
    final currentState = await getNotificationsEnabled();
    final newState = !currentState;
    await setNotificationsEnabled(newState);
    return newState;
  }

  /// Toggle push notification preference
  static Future<bool> togglePushNotifications() async {
    final currentState = await getPushNotificationsEnabled();
    final newState = !currentState;
    await setPushNotificationsEnabled(newState);
    return newState;
  }
}
