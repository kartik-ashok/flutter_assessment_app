import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart'; // Assuming you have AppColors defined

class AppTextStyles {
  // fontSize: 10
  static final TextStyle size10w400Grey = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: ResponsiveSize.font(10),
    color: AppColors.secondaryGrey,
  );

  static final TextStyle size10w500Blue = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: ResponsiveSize.font(10),
    color: AppColors.secondaryBlue,
  );
  static final TextStyle size10w500white = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: ResponsiveSize.font(10),
    color: AppColors.white,
  );

  // fontSize: 14
  static final TextStyle size14w400Grey = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: ResponsiveSize.font(14),
    color: AppColors.secondaryGrey,
  );

  static final TextStyle size14w500Blue = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: ResponsiveSize.font(14),
    color: AppColors.secondaryBlue,
  );
  // fontSize: 12
  static final TextStyle size12w400Grey = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: ResponsiveSize.font(12),
    color: AppColors.secondaryGrey,
  );

  static final TextStyle size12w500Blue = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: ResponsiveSize.font(12),
    color: AppColors.secondaryBlue,
  );
  static final TextStyle size12w500BemeraldGreen = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: ResponsiveSize.font(12),
    color: AppColors.emeraldGreen,
  );

  static final TextStyle size14w600Red = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: ResponsiveSize.font(14),
    color: AppColors.errorRed,
  );

  static final TextStyle size14w700Black = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: ResponsiveSize.font(14),
    color: AppColors.black,
  );

  static final TextStyle size16wboldBlack = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: ResponsiveSize.font(16),
    color: AppColors.white,
  );

  // fontSize: 24
  static final TextStyle size24w400Grey = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    color: AppColors.secondaryGrey,
  );

  static final TextStyle size24w600Blue = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: ResponsiveSize.font(24),
    color: AppColors.secondaryBlue,
  );

  static final TextStyle size24w700Black = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: ResponsiveSize.font(24),
    color: AppColors.black,
  );
}
