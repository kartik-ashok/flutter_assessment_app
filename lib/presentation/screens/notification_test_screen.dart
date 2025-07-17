import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/utils/firebase_messaging_service.dart';
import 'package:flutter_assessment_app/utils/notification_service.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';

class NotificationTestScreen extends StatefulWidget {
  const NotificationTestScreen({super.key});

  @override
  State<NotificationTestScreen> createState() => _NotificationTestScreenState();
}

class _NotificationTestScreenState extends State<NotificationTestScreen> {
  String? _fcmToken;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFcmToken();
  }

  Future<void> _loadFcmToken() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final token = FirebaseMessagingService().fcmToken;
      setState(() {
        _fcmToken = token;
      });
    } catch (e) {
      print('Error loading FCM token: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _copyTokenToClipboard() async {
    if (_fcmToken != null) {
      await Clipboard.setData(ClipboardData(text: _fcmToken!));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('FCM Token copied to clipboard!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _testLocalNotification() async {
    await NotificationService().showNotification(
      title: 'Test Local Notification',
      body: 'This is a test local notification from the app!',
      payload: 'test_local',
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Local notification sent!'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  Future<void> _subscribeToTestTopic() async {
    await FirebaseMessagingService().subscribeToTopic('test_notifications');

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subscribed to test_notifications topic!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _unsubscribeFromTestTopic() async {
    await FirebaseMessagingService().unsubscribeFromTopic('test_notifications');

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unsubscribed from test_notifications topic!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        title: const Text(
          'Notification Testing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveSize.width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// FCM Token Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ResponsiveSize.width(16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ResponsiveSize.width(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: ResponsiveSize.width(5),
                    offset: Offset(0, ResponsiveSize.height(2)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FCM Token',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: ResponsiveSize.height(8)),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_fcmToken != null) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(ResponsiveSize.width(12)),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius:
                            BorderRadius.circular(ResponsiveSize.width(8)),
                      ),
                      child: Text(
                        _fcmToken!,
                        style: TextStyle(
                          fontSize: ResponsiveSize.width(12),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    SizedBox(height: ResponsiveSize.height(12)),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _copyTokenToClipboard,
                        icon: const Icon(Icons.copy),
                        label: const Text('Copy Token'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ] else
                    const Text('No FCM token available'),
                ],
              ),
            ),

            SizedBox(height: ResponsiveSize.height(16)),

            /// Test Buttons Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ResponsiveSize.width(16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ResponsiveSize.width(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: ResponsiveSize.width(5),
                    offset: Offset(0, ResponsiveSize.height(2)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Test Notifications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: ResponsiveSize.height(16)),

                  /// Test Local Notification
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _testLocalNotification,
                      icon: const Icon(Icons.notifications),
                      label: const Text('Test Local Notification'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: ResponsiveSize.height(12)),

                  /// Subscribe to Test Topic
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _subscribeToTestTopic,
                      icon: const Icon(Icons.add_circle),
                      label: const Text('Subscribe to Test Topic'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: ResponsiveSize.height(12)),

                  /// Unsubscribe from Test Topic
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _unsubscribeFromTestTopic,
                      icon: const Icon(Icons.remove_circle),
                      label: const Text('Unsubscribe from Test Topic'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveSize.height(16)),

            /// Instructions Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ResponsiveSize.width(16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ResponsiveSize.width(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: ResponsiveSize.width(5),
                    offset: Offset(0, ResponsiveSize.height(2)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How to Test Push Notifications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: ResponsiveSize.height(12)),
                  Text(
                    '1. Copy the FCM token above\n'
                    '2. Use Firebase Console or a testing tool\n'
                    '3. Send a test message to the token\n'
                    '4. Or subscribe to "test_notifications" topic\n'
                    '5. Send a topic message from Firebase Console',
                    style: TextStyle(
                      fontSize: ResponsiveSize.width(14),
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
