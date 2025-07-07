import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/presentation/screens/my_assessments.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Widget _buildLanguageSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(20)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '🇬🇧',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(width: 4),
          Text(
            'Eng',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down,
            size: 18,
          )
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [],
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Enter your email',
        prefixIcon: const Icon(Icons.email_outlined),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.arrow_forward,
        size: 20,
      ),
      label: const Text(
        'Continue',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
        backgroundColor: const Color(0xFF256EFF),
        elevation: 4,
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyAssessments()));
      },
    );
  }

  Widget _buildSupport() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.headset_mic_outlined, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'Support',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomWave(BuildContext context) {
    // To create the blue wave shape at the bottom
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: CustomPaint(
          painter: BottomWavePainter(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Screen white background with support zone bottom with blue waves
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 48),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildLanguageSelector(),
                ),
              ),
              const SizedBox(height: 36),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/allycare.png', // Replace with your logo asset
                      width: 202,
                      height: 66,
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: _buildEmailInput(),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: _buildEmailInput(),
                    ),
                    const SizedBox(height: 24),
                    _buildContinueButton(context),
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(
                  height: 64), // Padding for bottom wave and support region
            ],
          ),
          _buildBottomWave(context),
          Positioned(
            bottom: 28,
            width: MediaQuery.of(context).size.width,
            child: _buildSupport(),
          )
        ],
      ),
    );
  }
}

class BottomWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = const Color(0xFF2B6BE8);
    final path1 = Path();
    path1.moveTo(0, size.height * 0.5);
    path1.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.5);
    path1.quadraticBezierTo(
        size.width * 0.75, size.height * 0.3, size.width, size.height * 0.5);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    final paint2 = Paint()..color = const Color(0xFF7BAAFB);
    final path2 = Path();
    path2.moveTo(0, size.height * 0.6);
    path2.quadraticBezierTo(size.width * 0.25, size.height * 0.85,
        size.width * 0.5, size.height * 0.6);
    path2.quadraticBezierTo(
        size.width * 0.75, size.height * 0.35, size.width, size.height * 0.6);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
