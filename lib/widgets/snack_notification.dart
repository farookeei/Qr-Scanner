import 'package:flutter/material.dart';

void snakBarNotification(
    {@required String notification,
    @required GlobalKey<ScaffoldMessengerState> scaffoldkey,
    @required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(notification),
    duration: Duration(seconds: 3),
  ));
}
