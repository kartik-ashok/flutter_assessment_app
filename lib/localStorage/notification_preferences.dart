import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreferences {
  static const String _keyNotificationsEnabled = 'notifications_enabled';

  /// Get notification preference
  static Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNotificationsEnabled) ?? false;
  }

  /// Set notification preference
  static Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotificationsEnabled, enabled);
  }

  /// Toggle notification preference
  static Future<bool> toggleNotifications() async {
    final currentState = await getNotificationsEnabled();
    final newState = !currentState;
    await setNotificationsEnabled(newState);
    return newState;
  }
}
