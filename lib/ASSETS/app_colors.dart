import 'package:flutter/material.dart';

class AppColors {
  // Blues
  static const Color primaryBlue = Color(0xff255FD5);
  static const Color secondaryBlue = Color(0xff222E58);

  // Greys
  static const Color primaryGrey = Color(0xFFEAEAEA); // fixed: added 0x prefix
  static const Color secondaryGrey = Color(0xff434343);
  static const Color tertiaryGrey = Color(0xffE8E9ED);

  // Greens
  static const Color lightGreen = Color(0xFFA8E6CF);
  static const Color darkGreen = Color(0xFF388E3C);
  static const Color emeraldGreen = Color(0xff2B7A71);
  static const Color limeGreen = Color(0xFFC1EAD1);

  static const LinearGradient greenGradientOne = LinearGradient(
    colors: [Color(0xff91B655), Color(0xff69F5BB)],
  );
  static const LinearGradient greenGradientTwo = LinearGradient(
    colors: [Color(0xff69F5BB), Color(0xff69F5BB)],
  );
  static const LinearGradient orangeGradientone = LinearGradient(
    colors: [
      Color.fromARGB(255, 222, 150, 121),
      Color.fromARGB(255, 248, 237, 197)
    ],
  );

  // Black & White
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Accent
  static const Color secondaryOrange = Color(0xfff7941d);
  static const Color secondaryPink = Color(0xfff7941d); // (same as orange?)

  // Error Colors
  static const Color errorRed = Color(0xFFD32F2F);

  static const Color primarypink = Color(0xffFF88A5);
}
