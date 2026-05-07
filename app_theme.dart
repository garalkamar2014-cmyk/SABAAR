import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color navy = Color(0xFF1A2744);
  static const Color teal = Color(0xFF3ECFB0);
  static const Color lime = Color(0xFFC8E84A);
  static const Color limeText = Color(0xFF3A5000);
  static const Color bg = Color(0xFFE8EBE4);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF8A9090);
  static const Color stroke = Color(0x2E1A2744);
  static const Color holdYellow = Color(0xFFD8E060);

  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: navy,
        background: bg,
      ),
      scaffoldBackgroundColor: bg,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        bodyLarge: GoogleFonts.inter(color: navy),
        bodyMedium: GoogleFonts.inter(color: navy),
      ),
      useMaterial3: true,
    );
  }

  static TextStyle get heading1 => GoogleFonts.inter(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        color: navy,
        letterSpacing: -0.8,
      );

  static TextStyle get heading2 => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: navy,
        letterSpacing: -0.4,
      );

  static TextStyle get heading3 => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: navy,
      );

  static TextStyle get label => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: textMuted,
        letterSpacing: 0.4,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: navy,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: textMuted,
      );

  static TextStyle get pill => GoogleFonts.inter(
        fontSize: 9,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      );

  static BoxDecoration get cardDecoration => BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      );

  static BoxDecoration get headerDecoration => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFCCEADE), Color(0xFFD6ECDE), Color(0xFFE4EEDD)],
          stops: [0.0, 0.45, 1.0],
        ),
      );
}
