import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/ASSETS/app_colors.dart';
import 'package:flutter_assessment_app/domain/repository/auth_service.dart';
import 'package:flutter_assessment_app/presentation/screens/my_assessments.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLogin = false;

  Widget _buildLanguageSelector() {
    return Container(
      width: 81,
      height: 34,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/197374 1.png', width: 18, height: 18),
          Text(
            'Eng',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.secondaryGrey,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return SizedBox(
      width: 301,
      height: 52,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.secondaryGrey,
        ),
        decoration: InputDecoration(
          hintText: 'Enter your email',
          prefixIcon: const Icon(Icons.email_outlined),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Email is required';
          if (!value.contains('@')) return 'Enter a valid email';
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordInput() {
    return SizedBox(
      width: 301,
      height: 52,
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.secondaryGrey,
        ),
        decoration: InputDecoration(
          hintText: 'Enter your password',
          prefixIcon: const Icon(Icons.lock_outline),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Password is required';
          if (value.length < 6) return 'Password must be at least 6 characters';
          return null;
        },
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      height: 57,
      width: 190,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          backgroundColor: AppColors.primaryBlue,
          elevation: 4,
        ),
        onPressed: () => _submit(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Continue',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              size: 20,
              color: AppColors.white,
            ),
          ],
        ),
      ),
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

  void _submit(BuildContext context) async {
    print('Submit button pressed');

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("Form is valid");

      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      String? result;
      if (isLogin) {
        result = await _authService.signIn(email, password);
      } else {
        result = await _authService.signUp(email, password);
      }

      if (result != null) {
        print('Error: $result');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MyAssessments()),
        );
      }
    } else {
      print('Form is not valid');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid email and password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // default is true
      backgroundColor: Colors.white,

      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            // Use the main background image that defines the shape
            Image.asset(
              'assets/images/Vector 58.png',
              width: double.infinity,
              fit: BoxFit.fitWidth, // maintain original aspect ratio
              alignment: Alignment.bottomCenter,
            ),

            // Overlay second image if needed
            Image.asset(
              'assets/images/Vector 57.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),

            // Support text aligned properly
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: _buildSupport(),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 48),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _buildLanguageSelector(),
                  ),
                ),
                const SizedBox(height: 141),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/allyCare.png',
                          width: 202,
                          height: 66,
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: _buildEmailInput(),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: _buildPasswordInput(),
                        ),
                        const SizedBox(height: 26),
                        _buildContinueButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
