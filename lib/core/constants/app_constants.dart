/// Application-wide constants
class AppConstants {
  // App Information
  static const String appName = 'Flutter Assessment App';
  static const String appVersion = '1.0.0';

  // Shared Preferences Keys
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String isFirstTimeKey = 'is_first_time';

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;

  // Breakpoints for responsive design
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;

  // Image URLs (existing hardcoded URLs from the app)
  static const String imageBaseUrl = 'assets/images/';
  static const String allyCareLogoImage = '${imageBaseUrl}allycare.png';
  static const String flag = '${imageBaseUrl}flag.png';
  static const String waterWaveOne = '${imageBaseUrl}waveOne.png';
  static const String waterWaveTwo = '${imageBaseUrl}waveTwo.png';

  // Assessment and workout images (using placeholder URLs for now)
  static const String fitnessAssessmentImage =
      'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/0e3c8f2d-f25e-4e50-8662-cd7043a531c2.png';
  static const String healthRiskAssessmentImage =
      'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png';
  static const String sweatStarterWorkoutImage =
      'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/ac2a53ba-d701-48af-a851-3d6e37454e46.png';
  static const String strengthBuilderWorkoutImage =
      'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/91e988bf-1140-4937-bf4e-620ca60992d6.png';
}
