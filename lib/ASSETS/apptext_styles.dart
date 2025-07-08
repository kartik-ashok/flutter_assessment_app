import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart'; // Assuming you have AppColors defined

class AppTextStyles {
  static final TextStyle bodyMedium = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.secondaryGrey,
  );

  // Add more styles as needed
  static final TextStyle headingLarge = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: AppColors.secondaryBlue,
  );
}
