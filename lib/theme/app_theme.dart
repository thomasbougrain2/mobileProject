import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get theme {
    // Utilisez ColorScheme pour définir les couleurs primaires, secondaires, etc.
    final ColorScheme colorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      backgroundColor: const Color(0xFF15232E),
    ).copyWith(
      secondary: const Color(0xFFFF8100),
      primary: const Color(0xFFFFFFFF), // Utilisez primary au lieu de primaryColorDark
      onPrimary: Colors.white, // Pour le texte sur le fond primaire
    );

    return ThemeData(
      useMaterial3: true, // Assurez-vous d'utiliser Material 3 pour accéder aux dernières fonctionnalités
      colorScheme: colorScheme,
      textTheme: GoogleFonts.nunitoTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.grey),
          labelLarge: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.grey),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF15232E),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF15232E),
        iconTheme: const IconThemeData(color: Colors.white),
        // Corrigez en fournissant directement un TextStyle à toolbarTextStyle et titleTextStyle
        toolbarTextStyle: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ), // Directement un TextStyle sans .bodyText2
        titleTextStyle: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ), // Directement un TextStyle sans .headline6
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0F1E2B),
        selectedItemColor: Color(0xFF0A7AEE),
        unselectedItemColor: Color(0xFF778BA8),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFFF8100),
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
