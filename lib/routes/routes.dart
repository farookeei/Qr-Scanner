import 'package:flutter/material.dart';
import '../screens/allScreens.dart';

Map<String, WidgetBuilder> routes() {
  return {
    LoginScreen.routeName: (ctx) => LoginScreen(),
    UserRegistorScreen.routeName: (ctx) => UserRegistorScreen(),
    GeneratePage.routeName: (ctx) => GeneratePage(),
    Userhome.routeName: (ctx) => Userhome(),
    AdminHome.routeName: (ctx) => AdminHome(),
    ScanPage.routeName: (ctx) => ScanPage(),
    UserDetailsEditScreen.routeName: (ctx) => UserDetailsEditScreen(),
    UserDetailsScreen.routeName: (ctx) => UserDetailsScreen(),
    AdminLoginScreen.routeName: (ctx) => AdminLoginScreen(),
    AdminRegistorScreen.routeName: (ctx) => AdminRegistorScreen(),
    FetchDetails.routeName: (ctx) => FetchDetails(),
  };
}
