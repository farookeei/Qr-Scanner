import 'package:flutter/material.dart';
import './allThemes.dart';
import 'appBarThemes.dart';
import 'textThemes/accentTextTheme.dart';
import 'textThemes/textTheme.dart';

// Color darkBlue = Color(0xff424753);
// Color grey = Color(0xffB9B9B9);
// Color secondary = Color(0x50292D42);
// Color danger = Color.fromRGBO(241, 92, 77, 1);
// Color ratingColor = Color.fromRGBO(245, 245, 245, 1);
// Color green = Color.fromRGBO(45, 207, 90, 1);
// Color shadowGrey = Color.fromRGBO(192, 182, 157, 0.15);
// Color warning = Color.fromRGBO(255, 199, 0, 1);
// const Color success = Color(0xff8fa620);
// Color darkPrimary = Color(0xff292d42);
// const Color borderColor1 = Color(0xffCACFE2);
// const Color bgSecondary = Color(0xfff4f4f4);
// const Color borderColor2 = Color(0xff8A8A8A);
// const Color subtitle1 = Color.fromRGBO(185, 185, 185, 1);
const Color iconColor = Color(0xff878994);

ThemeData themes() {
  return ThemeData(
      primarySwatch: Colors.blue,
      primaryTextTheme: primaryTextTheme(),
      accentTextTheme: accentTextTheme(),
      textTheme: texttheme(),
      primaryColor: Colors.blue,
      accentColor: Color(0xff8FA620),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme());
}
