import 'package:flutter/material.dart';

import '../mainThemes.dart';

TextTheme texttheme() => TextTheme(
      headline6: TextStyle(
          fontFamily: 'poppins',
          color: Colors.black,
          fontWeight: FontWeight.w500),
      headline5: TextStyle(
          fontFamily: 'poppins',
          color: Colors.black,
          fontWeight: FontWeight.w600),
      headline4: TextStyle(
          fontFamily: 'poppins',
          color: Colors.black,
          fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          fontFamily: 'poppins',
          color: Colors.black,
          fontWeight: FontWeight.w600),
      // bodyText2: TextStyle(
      //     fontFamily: 'poppins',
      //     color: borderColor2,
      //     fontSize: 12,
      //     fontWeight: FontWeight.w600),
      subtitle2: TextStyle(
          fontFamily: 'poppins',
          color: Color.fromRGBO(185, 185, 185, 1),
          fontSize: 10,
          fontWeight: FontWeight.w500),
      subtitle1: TextStyle(
          fontFamily: 'poppins',
          fontSize: 11,
          color: Color.fromRGBO(185, 185, 185, 1),
          fontWeight: FontWeight.w500),
      caption: TextStyle(
          fontFamily: 'poppins', fontSize: 10, fontWeight: FontWeight.w700),
    );
