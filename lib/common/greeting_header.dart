import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/ASSETS/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GreetingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;

  const GreetingAppBar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hello ${name}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: AppColors.primaryBlue,
              ),
            ),
            Container(
                width: 23,
                height: 23,
                decoration: const BoxDecoration(
                  color: Color(0xfff1f1f6),
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/icons/profile-picture.png')),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
