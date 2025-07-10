import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/assets/image_paths.dart';
import 'package:flutter_assessment_app/domain/repository/auth_service.dart';
import 'package:flutter_assessment_app/presentation/screens/my_dashboard.dart';
import 'package:flutter_assessment_app/presentation/widgets/awesome_snackbar.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';

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
  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  void _togglePasswordVisibility() {
    _isObscure.value = !_isObscure.value;
  }

  @override
  void dispose() {
    _isObscure.dispose();
    super.dispose();
  }

  Widget _buildLanguageSelector() {
    return Container(
      width: ResponsiveSize.width(83),
      padding: EdgeInsets.all(ResponsiveSize.width(6)),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(ResponsiveSize.width(16))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(ImagePaths.flag,
              width: ResponsiveSize.width(18),
              height: ResponsiveSize.height(18)),
          Text(
            'Eng',
            style: AppTextStyles.size14w500Blue,
          ),
          Icon(Icons.keyboard_arrow_down, size: ResponsiveSize.width(18)),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return SizedBox(
      width: ResponsiveSize.width(302),
      height: ResponsiveSize.height(52),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: AppTextStyles.size14w400Grey,
        decoration: InputDecoration(
          hintText: 'Enter your email',
          prefixIcon: const Icon(Icons.email_outlined),
          contentPadding: EdgeInsets.symmetric(
              vertical: ResponsiveSize.height(16),
              horizontal: ResponsiveSize.width(8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
            borderSide: const BorderSide(color: AppColors.tertiaryGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
            borderSide: BorderSide(
                color: Colors.blue.shade700, width: ResponsiveSize.width(1)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
            borderSide: BorderSide(
                color: Colors.grey.shade700, width: ResponsiveSize.width(1)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
            borderSide: BorderSide(
                color: Colors.grey.shade700, width: ResponsiveSize.width(1)),
          ),

          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(
              height: ResponsiveSize.height(
                  0.5)), // make error text take less space
          // helperText: ' ', // keep vertical space always
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
      width: ResponsiveSize.width(302),
      height: ResponsiveSize.height(52),
      child: ValueListenableBuilder(
        valueListenable: _isObscure,
        builder: (context, isObscure, child) => TextFormField(
          controller: _passwordController,
          obscureText: isObscure,
          style: AppTextStyles.size14w400Grey,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                isObscure ? Icons.visibility_off : Icons.visibility,
                color: AppColors.secondaryGrey,
              ),
              onPressed: _togglePasswordVisibility,
            ),

            contentPadding: EdgeInsets.symmetric(
                vertical: ResponsiveSize.height(16),
                horizontal: ResponsiveSize.width(8)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
              borderSide: BorderSide(
                  color: Colors.blue.shade700, width: ResponsiveSize.width(1)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
              borderSide: BorderSide(
                  color: Colors.grey.shade700, width: ResponsiveSize.width(1)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
              borderSide: BorderSide(
                  color: Colors.grey.shade700, width: ResponsiveSize.width(1)),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            // 👇 Reserve space for error text to avoid shifting
            errorStyle: TextStyle(
                height: ResponsiveSize.height(
                    0.5)), // make error text take less space
            // helperText: ' ', // keep vertical space always
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Password is required';
            if (value.length < 6)
              return 'Password must be at least 6 characters';
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.height(57),
      width: ResponsiveSize.width(190),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.width(28.5)),
          ),
          padding: EdgeInsets.symmetric(
              vertical: ResponsiveSize.height(14),
              horizontal: ResponsiveSize.width(32)),
          backgroundColor: AppColors.primaryBlue,
          elevation: ResponsiveSize.width(4),
        ),
        onPressed: () => _submit(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ValueListenableBuilder(
                valueListenable: _isLoading,
                builder: (context, _isLoading, child) {
                  return Text(_isLoading ? 'Loading...' : 'Continue',
                      style: AppTextStyles.size16wboldBlack);
                }),
            Icon(
              Icons.arrow_forward,
              size: ResponsiveSize.width(20),
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupport() {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveSize.height(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImagePaths.headphone),
          SizedBox(width: ResponsiveSize.width(8)),
          Text(
            'Support',
            style: AppTextStyles.size16w500white,
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context) async {
    _isLoading.value = true;
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      String? result;
      if (isLogin) {
        result = await _authService.signIn(email, password);
      } else {
        result = await _authService.signUp(email, password);
      }

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 2),
              content: Text(
                  "The email address is already in use by another account.")),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyDashboard()),
        );
      }
    } else {
      const SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Please enter valid email and password"));
    }
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // keep as-is
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              ImagePaths.waterWaveTwo,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
            Image.asset(
              ImagePaths.waterWaveOne,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
            Positioned(
              bottom: ResponsiveSize.height(12),
              left: 0,
              right: 0,
              child: _buildSupport(),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.all(ResponsiveSize.width(8)),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: _buildLanguageSelector(),
                        ),
                        SizedBox(height: ResponsiveSize.height(100)),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  ImagePaths.allyCare,
                                  width: ResponsiveSize.width(202),
                                  height: ResponsiveSize.height(66),
                                ),
                                SizedBox(height: ResponsiveSize.height(40)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveSize.width(32)),
                                  child: _buildEmailInput(),
                                ),
                                SizedBox(height: ResponsiveSize.height(20)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveSize.width(32)),
                                  child: _buildPasswordInput(),
                                ),
                                SizedBox(height: ResponsiveSize.height(26)),
                                _buildContinueButton(context),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Text(
                                    isLogin
                                        ? "Don't have an account? Sign Up"
                                        : "Already have an account? Log In",
                                    style: AppTextStyles.size14w500Blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
