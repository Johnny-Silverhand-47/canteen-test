import 'package:flutter/material.dart';

import 'colors.dart';

const yuGothicUI='YuGothicUI';

TextTheme get textTheme => const TextTheme(
      displayLarge: TextStyle(
        fontSize: 99,
        fontWeight: FontWeight.w300,
        color: AppColors.text,
        fontFamily: yuGothicUI,
      ),
      displayMedium: TextStyle(
        fontSize: 62,
        fontWeight: FontWeight.w300,
        color: AppColors.text,
        fontFamily: yuGothicUI,
      ),
      displaySmall: TextStyle(
        fontSize: 49,
        fontWeight: FontWeight.w400,
        fontFamily: yuGothicUI,
        color: AppColors.text,
      ),
      headlineMedium: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: yuGothicUI,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
        fontFamily: yuGothicUI,
      ),
      titleLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w500,
        fontFamily: yuGothicUI,
        color: AppColors.text,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: yuGothicUI,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
        fontFamily: yuGothicUI,
        letterSpacing: -0.28,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: yuGothicUI,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: yuGothicUI,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
        fontFamily: yuGothicUI,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.label,
        fontFamily: yuGothicUI,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: yuGothicUI,
      ),
    );

// To add custom text theme name
extension CustomStyles on TextTheme {
  TextStyle get buttonStyle {
    return const TextStyle(
      fontSize: 20,
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: yuGothicUI,
    );
  }

  TextStyle get error {
    return const TextStyle(
      fontSize: 18.0,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get success {
    return const TextStyle(
      fontSize: 18.0,
      color: Colors.green,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get phoneInput {
    return const TextStyle(
      fontSize: 13,
      color: AppColors.text,
      fontWeight: FontWeight.w500,
      fontFamily: yuGothicUI,
    );
  }
}
