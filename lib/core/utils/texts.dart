import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'night_day.dart';

class Texts {
  static Text textAppBar(String text) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.brown,
      ),
    );
  }

  static Text text12(String text) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 12,
        color: NightDay.isNight ? Colors.white : Colors.black,
      ),
    );
  }

  static Text text14(String text) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 14,
        color: NightDay.isNight ? Colors.white : Colors.black,
      ),
    );
  }

  static Text text14White(String text) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 14,
        color: NightDay.isNight ? Colors.white : Colors.black,
      ),
    );
  }

  static Text text14W700(String text) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 14,
        color: NightDay.isNight ? Colors.white : Colors.black,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static Text text16(String text) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 16,
        color: NightDay.isNight ? Colors.white : Colors.black,
      ),
    );
  }

  static Text text18(String text) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 18,
        color: NightDay.isNight ? Colors.white : Colors.black,
      ),
    );
  }

  static Text text18White(String text) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 18,
        color: NightDay.isNight ? Colors.white : Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static Text text16Brown(String text) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: 16,
        color: Colors.brown,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
