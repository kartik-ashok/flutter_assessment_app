import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_assessment_app/utils/notification_service.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance = FirebaseMessagingService._internal();
  factory FirebaseMessagingService() => _instance;
  FirebaseMessagingService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken;
  bool _isInitialized = false;

  String? get fcmToken => _fcmToken;
  bool get isInitialized => _isInitialized;

  /// Initialize Firebase Messaging
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Request permission for iOS
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }

      // Get FCM token
      _fcmToken = await _firebaseMessaging.getToken();
      print('FCM Token: $_fcmToken');

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        print('FCM Token refreshed: $newToken');
        // TODO: Send token to your server
      });

      // Configure foreground notification presentation options for iOS
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle notification taps when app is in background
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // Handle notification tap when app is terminated
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageOpenedApp(initialMessage);
      }

      _isInitialized = true;
    } catch (e) {
      print('Error initializing Firebase Messaging: $e');
    }
  }

  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    print('Received foreground message: ${message.messageId}');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');

    // Show local notification for foreground messages
    _showLocalNotification(message);
  }

  /// Handle notification tap when app is opened from background
  void _handleMessageOpenedApp(RemoteMessage message) {
    print('Message clicked: ${message.messageId}');
    print('Data: ${message.data}');

    // Handle navigation based on message data
    _handleNotificationNavigation(message.data);
  }

  /// Show local notification for foreground messages
  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      await NotificationService().showNotification(
        id: message.hashCode,
        title: message.notification?.title ?? 'Health App',
        body: message.notification?.body ?? 'You have a new message',
        payload: jsonEncode(message.data),
      );
    } catch (e) {
      print('Error showing local notification: $e');
    }
  }

  /// Handle navigation based on notification data
  void _handleNotificationNavigation(Map<String, dynamic> data) {
    // TODO: Implement navigation logic based on data
    String? screen = data['screen'];
    String? action = data['action'];

    print('Navigation - Screen: $screen, Action: $action');

    // Example navigation logic:
    // if (screen == 'appointments') {
    //   Navigator.pushNamed(context, '/appointments');
    // } else if (screen == 'assessments') {
    //   Navigator.pushNamed(context, '/assessments');
    // }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic $topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic $topic: $e');
    }
  }

  /// Send token to server (implement your API call here)
  Future<void> sendTokenToServer(String token) async {
    try {
      // TODO: Implement your API call to send token to server
      print('Sending token to server: $token');
      
      // Example API call:
      // final response = await http.post(
      //   Uri.parse('https://your-api.com/fcm-token'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({'token': token, 'userId': 'current_user_id'}),
      // );
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }

  /// Get delivery metrics (Android only)
  Future<void> getDeliveryMetrics() async {
    if (Platform.isAndroid) {
      try {
        final metrics = await _firebaseMessaging.getNotificationSettings();
        print('Notification settings: $metrics');
      } catch (e) {
        print('Error getting delivery metrics: $e');
      }
    }
  }

  /// Delete FCM token
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      print('FCM token deleted');
    } catch (e) {
      print('Error deleting FCM token: $e');
    }
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Data: ${message.data}');

  // You can perform background tasks here
  // Note: Don't call Navigator or show dialogs in background handler
}
