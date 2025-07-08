import 'package:flutter/material.dart';

/// Application color palette
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xff255FD5);
  static const Color primaryVariant = Color(0xFF1E5BC7);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary Colors
  static const Color secondary = Color(0xFF71AADF);
  static const Color secondaryVariant = Color(0xFF5A8BC4);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Accent Colors
  static const Color accent = Color(0xffEAEAEA);
  static const Color accentVariant = Color(0xff434343);
  static const Color onAccent = Color(0xFFFFFFFF);

  // Surface Colors (Light Theme)
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color surfaceVariant = Color(0xFFF3F2F7);
  static const Color onSurfaceVariant = Color(0xFF49454F);

  // Background Colors (Light Theme)
  static const Color background = Color(0xFFFFFBFE);
  static const Color onBackground = Color(0xFF1C1B1F);

  // Error Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // Success Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successContainer = Color(0xFFE8F5E8);
  static const Color onSuccessContainer = Color(0xFF1B5E20);

  // Warning Colors
  static const Color warning = Color(0xFFFF9800);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningContainer = Color(0xFFFFF3E0);
  static const Color onWarningContainer = Color(0xFFE65100);

  // Info Colors
  static const Color info = Color(0xFF2196F3);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoContainer = Color(0xFFE3F2FD);
  static const Color onInfoContainer = Color(0xFF0D47A1);

  // Neutral Colors
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFCAC4D0);
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);

  // Dark Theme Colors
  static const Color darkSurface = Color(0xFF1C1B1F);
  static const Color darkOnSurface = Color(0xFFE6E1E5);
  static const Color darkSurfaceVariant = Color(0xFF49454F);
  static const Color darkOnSurfaceVariant = Color(0xFFCAC4D0);

  static const Color darkBackground = Color(0xFF141218);
  static const Color darkOnBackground = Color(0xFFE6E1E5);

  static const Color darkShadow = Color(0xFF000000);
  static const Color darkScrim = Color(0xFF000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Tag Colors (for workout tags, etc.)
  static const Color loseWeightTag = Color(0xFF71AADF);
  static const Color buildMuscleTag = Color(0xFF70C19E);
  static const Color cardioTag = Color(0xFFFF9800);
  static const Color strengthTag = Color(0xFFE91E63);
  static const Color flexibilityTag = Color(0xFF9C27B0);

  // Status Colors
  static const Color activeStatus = Color(0xFF4CAF50);
  static const Color inactiveStatus = Color(0xFF9E9E9E);
  static const Color pendingStatus = Color(0xFFFF9800);
  static const Color completedStatus = Color(0xFF2196F3);

  // Appointment Type Colors
  static const Color cancerAppointment = Color(0xFF2196F3);
  static const Color physiotherapyAppointment = Color(0xFFE91E63);
  static const Color fitnessAppointment = Color(0xFFFF9800);

  // Challenge Colors
  static const Color challengeBackground = Color(0xFFE8F5E8);
  static const Color challengeProgress = Color(0xFF4CAF50);
  static const Color challengeIncomplete = Color(0xFFE0E0E0);

  // Shimmer Colors (for loading states)
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color darkShimmerBase = Color(0xFF424242);
  static const Color darkShimmerHighlight = Color(0xFF616161);
}
