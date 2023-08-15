import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Color(0xFF46531F),
      fontSize: 30,
      fontFamily: 'Rogerex',
      fontWeight: FontWeight.w600,
      height: 1.12,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF9E9E9E),
      fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      height: 1.57,
    ),
    displayMedium: TextStyle(
      color: Color(0xFF273240),
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
  ),
);
