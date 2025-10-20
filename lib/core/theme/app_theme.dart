import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final TextTheme textTheme = GoogleFonts.antonTextTheme();
  static final Color primary = fromHex('#2C3545');
  static final Color onPrimary = fromHex('#FFFFFF');

  static final Color secondary = fromHex('#D7FDEC');
  static final Color onSecondary = fromHex('#FFFFFF');

  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
