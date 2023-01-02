import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
    primarySwatch: Colors.purple,
    textTheme: TextTheme(
        bodyText2: TextStyle(
            fontFamily: GoogleFonts.bubblegumSans().fontFamily,
            fontSize: 40,
            color: Colors.white)),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.bubblegumSans().fontFamily,
          fontSize: 40,
          color: Colors.purple),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            TextStyle(fontFamily: GoogleFonts.bubblegumSans().fontFamily, fontSize: 20),
            backgroundColor: Colors.purple,
      ),
    ));
