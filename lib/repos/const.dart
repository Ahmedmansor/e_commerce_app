import 'package:flutter/material.dart';

abstract class ThemeText {
  static const TextStyle boardingScreenBody = TextStyle(
      // fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 40,
      fontWeight: FontWeight.w600);

  static const TextStyle boardingScreenBodysmall = TextStyle(
      // fontFamily: 'Montserrat',
      color: Colors.grey,
      fontSize: 14,
      height: 1,
      fontWeight: FontWeight.w400);

  static const TextStyle progressFooter = TextStyle(
      // fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w600);

  static const TextStyle iconsNameBold = TextStyle(
      // fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w400);

  static const TextStyle medumFontBold = TextStyle(
      // fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w400);
  static const TextStyle medumFontBoldBlack = TextStyle(
      // fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.w400);

  static const TextStyle medumFontBlue = TextStyle(
      // fontFamily: 'Montserrat',
      color: Colors.blue,
      fontSize: 20,
      fontWeight: FontWeight.w400);

  static const TextStyle pageTitle = TextStyle(
      // fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600);

  static const TextStyle reularbold = TextStyle(
      // fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500);
}

String? token;

class AppFont {
  static const regular = TextStyle(
    fontFamily: 'Metro',
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontSize: 18,
  );

  static const medium = TextStyle(
    fontFamily: 'Metro',
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 18,
  );

  static const bold = TextStyle(
    fontFamily: 'Metro',
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 18,
  );
  static const semiBold = TextStyle(
    fontFamily: 'Metro',
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 18,
  );
}
