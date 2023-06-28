import 'package:flutter/material.dart';

import 'colors.dart';

const quicksand = 'Quicksand';
const poppins = 'Poppins';
const montserrat = 'Montserrat';

TextTheme get textTheme => const TextTheme(
      displayLarge: TextStyle(
        fontSize: 99,
        fontWeight: FontWeight.w300,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      displayMedium: TextStyle(
        fontSize: 62,
        fontWeight: FontWeight.w300,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      displaySmall: TextStyle(
        fontSize: 49,
        fontWeight: FontWeight.w400,
        fontFamily: quicksand,
        color: AppColors.text,
      ),
      headlineMedium: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      titleLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w500,
        fontFamily: quicksand,
        color: AppColors.text,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
        fontFamily: quicksand,
      ),
    );

// To add custom text theme name
extension CustomStyles on TextTheme {
  TextStyle get buttonStyle {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.text,
      fontWeight: FontWeight.w700,
      fontFamily: quicksand,
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
      fontFamily: quicksand,
    );
  }
}
