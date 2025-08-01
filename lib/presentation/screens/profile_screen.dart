import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/domain/repository/auth_service.dart';
import 'package:flutter_assessment_app/localStorage/app_prefrence.dart';
import 'package:flutter_assessment_app/localStorage/notification_preferences.dart';
import 'package:flutter_assessment_app/presentation/screens/add_data_buttons.dart';
import 'package:flutter_assessment_app/presentation/screens/favorites_screen.dart';
import 'package:flutter_assessment_app/presentation/screens/login_page.dart';
import 'package:flutter_assessment_app/presentation/screens/notification_test_screen.dart';
import 'package:flutter_assessment_app/utils/notification_service.dart';
import 'package:flutter_assessment_app/utils/firebase_messaging_service.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:page_transition/page_transition.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController(text: 'user@example.com'); // Mock email
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isObscure = true;
  bool _notificationsEnabled = false;
  bool _pushNotificationsEnabled = true;
  bool _healthRemindersEnabled = true;
  bool _appointmentRemindersEnabled = true;

  Future<String?> email() async {
    return await AppPreferences.getEmail();
  }

  @override
  void initState() {
    super.initState();
    _loadEmail();
    _loadNotificationPreferences();
  }

  Future<void> _loadEmail() async {
    final userEmail = await AppPreferences.getEmail();
    if (userEmail != null) {
      setState(() {
        emailController.text = userEmail;
      });
    }
  }

  Future<void> _loadNotificationPreferences() async {
    final localEnabled =
        await NotificationPreferences.getNotificationsEnabled();
    final pushEnabled =
        await NotificationPreferences.getPushNotificationsEnabled();
    final healthEnabled =
        await NotificationPreferences.getHealthRemindersEnabled();
    final appointmentEnabled =
        await NotificationPreferences.getAppointmentRemindersEnabled();

    setState(() {
      _notificationsEnabled = localEnabled;
      _pushNotificationsEnabled = pushEnabled;
      _healthRemindersEnabled = healthEnabled;
      _appointmentRemindersEnabled = appointmentEnabled;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });

    await NotificationPreferences.setNotificationsEnabled(value);

    if (value) {
      await NotificationService().startRepeatingNotifications();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Health notifications enabled! You\'ll receive reminders every 10 seconds.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      NotificationService().stopRepeatingNotifications();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Health notifications disabled.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _togglePushNotifications(bool value) async {
    setState(() {
      _pushNotificationsEnabled = value;
    });

    await NotificationPreferences.setPushNotificationsEnabled(value);

    if (value) {
      // Subscribe to topics when enabled
      await FirebaseMessagingService().subscribeToTopic('health_reminders');
      await FirebaseMessagingService()
          .subscribeToTopic('appointment_reminders');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Push notifications enabled! You\'ll receive health updates.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      // Unsubscribe from topics when disabled
      await FirebaseMessagingService().unsubscribeFromTopic('health_reminders');
      await FirebaseMessagingService()
          .unsubscribeFromTopic('appointment_reminders');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Push notifications disabled.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _toggleHealthReminders(bool value) async {
    setState(() {
      _healthRemindersEnabled = value;
    });

    await NotificationPreferences.setHealthRemindersEnabled(value);

    if (value) {
      await FirebaseMessagingService().subscribeToTopic('health_reminders');
    } else {
      await FirebaseMessagingService().unsubscribeFromTopic('health_reminders');
    }
  }

  Future<void> _toggleAppointmentReminders(bool value) async {
    setState(() {
      _appointmentRemindersEnabled = value;
    });

    await NotificationPreferences.setAppointmentRemindersEnabled(value);

    if (value) {
      await FirebaseMessagingService()
          .subscribeToTopic('appointment_reminders');
    } else {
      await FirebaseMessagingService()
          .unsubscribeFromTopic('appointment_reminders');
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        String newEmail = emailController.text.trim();

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updateEmail(newEmail);
          await user.reload(); // Refresh user
          user = FirebaseAuth.instance.currentUser;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email updated successfully')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update email: $e')),
        );
      }
    }
  }

  void _logout() async {
    await AuthService().signOut(); // Sign out from Firebase
    await AppPreferences.clearAll(); // Clear stored data if needed

    // Show logout success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );

    // Navigate to login screen (replace with your login screen route)
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Optional soft background
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: AppColors.primaryBlue,
        elevation: ResponsiveSize.width(2),
      ),
      body: Padding(
        padding: EdgeInsets.all(ResponsiveSize.width(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
                ),
                elevation: ResponsiveSize.width(4),
                child: Padding(
                  padding: EdgeInsets.all(ResponsiveSize.width(20)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Info',
                          style: AppTextStyles.size10w400Grey,
                        ),
                        SizedBox(height: ResponsiveSize.height(16)),

                        /// Email Field
                        Text(
                          'Email',
                          style: AppTextStyles.size10w500white.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: ResponsiveSize.height(6)),
                        TextFormField(
                          controller: emailController,
                          readOnly: true,
                          style: AppTextStyles.size10w500Blue,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ResponsiveSize.width(10)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: ResponsiveSize.height(24)),

                        /// Favorites Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: const FavoritesScreen(),
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              );
                            },
                            icon:
                                const Icon(Icons.favorite, color: Colors.white),
                            label: Text(
                              'My Favorites',
                              style: AppTextStyles.size14w500Blue
                                  .copyWith(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: ResponsiveSize.height(14)),
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ResponsiveSize.width(12)),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: ResponsiveSize.height(16)),

                        /// Notification Toggle
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(ResponsiveSize.width(16)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(ResponsiveSize.width(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: ResponsiveSize.width(5),
                                offset: Offset(0, ResponsiveSize.height(2)),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications_active,
                                color: _notificationsEnabled
                                    ? Colors.green
                                    : Colors.grey,
                                size: ResponsiveSize.width(24),
                              ),
                              SizedBox(width: ResponsiveSize.width(12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Health Notifications',
                                      style:
                                          AppTextStyles.size14w500Blue.copyWith(
                                        fontSize: ResponsiveSize.width(16),
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveSize.height(4)),
                                    Text(
                                      'Receive health reminders every 10 seconds',
                                      style: TextStyle(
                                        fontSize: ResponsiveSize.width(12),
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _notificationsEnabled,
                                onChanged: _toggleNotifications,
                                activeColor: Colors.green,
                                activeTrackColor: Colors.green.withOpacity(0.3),
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor:
                                    Colors.grey.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveSize.height(16)),

                        /// Push Notifications Toggle
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(ResponsiveSize.width(16)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(ResponsiveSize.width(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: ResponsiveSize.width(5),
                                offset: Offset(0, ResponsiveSize.height(2)),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.cloud_queue,
                                color: _pushNotificationsEnabled
                                    ? Colors.blue
                                    : Colors.grey,
                                size: ResponsiveSize.width(24),
                              ),
                              SizedBox(width: ResponsiveSize.width(12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Push Notifications',
                                      style:
                                          AppTextStyles.size14w500Blue.copyWith(
                                        fontSize: ResponsiveSize.width(16),
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveSize.height(4)),
                                    Text(
                                      'Receive health updates from server',
                                      style: TextStyle(
                                        fontSize: ResponsiveSize.width(12),
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _pushNotificationsEnabled,
                                onChanged: _togglePushNotifications,
                                activeColor: Colors.blue,
                                activeTrackColor: Colors.blue.withOpacity(0.3),
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor:
                                    Colors.grey.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveSize.height(12)),

                        /// Health Reminders Toggle
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(ResponsiveSize.width(16)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(ResponsiveSize.width(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: ResponsiveSize.width(5),
                                offset: Offset(0, ResponsiveSize.height(2)),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.health_and_safety,
                                color: _healthRemindersEnabled
                                    ? Colors.green
                                    : Colors.grey,
                                size: ResponsiveSize.width(24),
                              ),
                              SizedBox(width: ResponsiveSize.width(12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Health Reminders',
                                      style:
                                          AppTextStyles.size14w500Blue.copyWith(
                                        fontSize: ResponsiveSize.width(16),
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveSize.height(4)),
                                    Text(
                                      'Get health tips and wellness reminders',
                                      style: TextStyle(
                                        fontSize: ResponsiveSize.width(12),
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _healthRemindersEnabled,
                                onChanged: _toggleHealthReminders,
                                activeColor: Colors.green,
                                activeTrackColor: Colors.green.withOpacity(0.3),
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor:
                                    Colors.grey.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveSize.height(12)),

                        /// Appointment Reminders Toggle
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(ResponsiveSize.width(16)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(ResponsiveSize.width(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: ResponsiveSize.width(5),
                                offset: Offset(0, ResponsiveSize.height(2)),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.event_note,
                                color: _appointmentRemindersEnabled
                                    ? Colors.orange
                                    : Colors.grey,
                                size: ResponsiveSize.width(24),
                              ),
                              SizedBox(width: ResponsiveSize.width(12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Appointment Reminders',
                                      style:
                                          AppTextStyles.size14w500Blue.copyWith(
                                        fontSize: ResponsiveSize.width(16),
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: ResponsiveSize.height(4)),
                                    Text(
                                      'Get notified about upcoming appointments',
                                      style: TextStyle(
                                        fontSize: ResponsiveSize.width(12),
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _appointmentRemindersEnabled,
                                onChanged: _toggleAppointmentReminders,
                                activeColor: Colors.orange,
                                activeTrackColor:
                                    Colors.orange.withOpacity(0.3),
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor:
                                    Colors.grey.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveSize.height(16)),

                        /// Test Notifications Button (Developer Option)
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const NotificationTestScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.bug_report),
                            label: const Text('Test Notifications (Dev)'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.purple,
                              side: const BorderSide(color: Colors.purple),
                              padding: EdgeInsets.symmetric(
                                vertical: ResponsiveSize.height(12),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: ResponsiveSize.height(16)),

                        /// Logout Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _logout,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: ResponsiveSize.height(14)),
                              backgroundColor: AppColors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ResponsiveSize.width(12)),
                              ),
                            ),
                            icon: const Icon(Icons.logout,
                                color: AppColors.white),
                            label: Text(
                              'Logout',
                              style: AppTextStyles.size14w600Red.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDataButtons(),
              ));
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     floatingActionButton: FloatingActionButton(
  //       backgroundColor: AppColors.primaryBlue,
  //       onPressed: () {
  //         Navigator.push(context, MaterialPageRoute(
  //           builder: (context) {
  //             return AddDataButtons();
  //           },
  //         ));
  //       },
  //       child: const Icon(
  //         Icons.add,
  //         color: AppColors.white,
  //       ),
  //     ),
  //     appBar: AppBar(
  //       title: const Text('Profile'),
  //       centerTitle: true,
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Card(
  //         elevation: 5,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Form(
  //             key: _formKey,
  //             child: ListView(
  //               shrinkWrap: true,
  //               children: [
  //                 const Text(
  //                   'Email',
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                 ),
  //                 const SizedBox(height: 6),
  //                 TextFormField(
  //                   controller: emailController,
  //                   readOnly: true,
  //                   decoration: const InputDecoration(
  //                     prefixIcon: Icon(Icons.email),
  //                     border: OutlineInputBorder(),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 ElevatedButton(
  //                   onPressed: _logout,
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: AppColors.primaryBlue,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(12)),
  //                   ),
  //                   child: Text(
  //                     'Logout',
  //                     style: AppTextStyles.size14w600Red
  //                         .copyWith(color: AppColors.white),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
