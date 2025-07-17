import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';
import 'dart:io';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Timer? _repeatingTimer;
  bool _isInitialized = false;
  bool _isRepeatingActive = false;

  bool get isRepeatingActive => _isRepeatingActive;

  /// Initialize the notification service
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz.initializeTimeZones();

    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions for Android 13+
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    _isInitialized = true;
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse notificationResponse) {
    print('Notification tapped: ${notificationResponse.payload}');
  }

  /// Show an immediate notification
  Future<void> showNotification({
    int id = 0,
    String title = 'Health Reminder',
    String body = 'Time for your health check!',
    String? payload,
  }) async {
    if (!_isInitialized) await initialize();

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'health_channel_id',
      'Health Notifications',
      channelDescription: 'Notifications for health reminders and updates',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Schedule a notification
  Future<void> scheduleNotification({
    int id = 1,
    String title = 'Scheduled Reminder',
    String body = 'This is your scheduled health reminder!',
    required Duration delay,
    String? payload,
  }) async {
    if (!_isInitialized) await initialize();

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(delay),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_health_channel_id',
          'Scheduled Health Notifications',
          channelDescription: 'Scheduled notifications for health reminders',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  /// Start repeating notifications every 10 seconds
  Future<void> startRepeatingNotifications() async {
    if (!_isInitialized) await initialize();

    if (_isRepeatingActive) return;

    _isRepeatingActive = true;

    // Show first notification immediately
    await showNotification(
      title: 'Health App Active',
      body: 'Your health notifications are now active!',
    );

    // Start repeating timer
    _repeatingTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (_isRepeatingActive) {
        final messages = [
          'Stay hydrated! Drink some water 💧',
          'Time for a quick stretch break 🧘‍♀️',
          'Remember to take your medications 💊',
          'Check your posture and sit up straight 🪑',
          'Take a deep breath and relax 😌',
          'Time for a healthy snack 🍎',
          'Don\'t forget your daily exercise 🏃‍♂️',
          'Stay positive and keep smiling 😊',
        ];

        final randomMessage = messages[DateTime.now().second % messages.length];

        await showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: 'Health Reminder',
          body: randomMessage,
          payload: 'repeating_notification',
        );
      }
    });
  }

  /// Stop repeating notifications
  void stopRepeatingNotifications() {
    _isRepeatingActive = false;
    _repeatingTimer?.cancel();
    _repeatingTimer = null;

    // Show stop notification
    showNotification(
      title: 'Notifications Stopped',
      body: 'Your repeating health notifications have been turned off.',
    );
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Cancel specific notification
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
