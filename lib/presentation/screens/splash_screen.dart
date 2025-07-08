import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/localStorage/app_prefrence.dart';
import 'package:flutter_assessment_app/presentation/screens/login_page.dart';
import 'package:flutter_assessment_app/presentation/screens/my_dashboard.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reDirectToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.health_and_safety, size: 100, color: Colors.blue),
      ),
    );
  }

  // Future<void> reDirectToHome() async {
  //   // Simulate a delay for splash screen
  //   await Future.delayed(const Duration(seconds: 2));
  //   String token = await AppPreferences.getToken();
  //   // Navigate to home page (not implemented in this snippet)
  //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               token.isNotEmpty ? const MyDashboard() : const LoginScreen()));
  // }
  Future<void> reDirectToHome(BuildContext context) async {
    // Simulate a delay for splash screen
    await Future.delayed(const Duration(seconds: 2));

    final token = await AppPreferences.getToken();

    // Check for non-null and non-empty token
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyDashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }
}
