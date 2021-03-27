import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void handleNotifications(BuildContext context) {
  final fbm = FirebaseMessaging();
  fbm.requestNotificationPermissions();

  //!onMessage foregrond
  fbm.configure(onMessage: (msg) {
    print(msg);

    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: ListTile(
              title: Text(
                msg['notification']['title'],
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              subtitle: Text(
                msg['notification']['body'],
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("OK"))
            ],
          );
        });

    //!launch terminated
  }, onLaunch: (msg) {
    print(msg);
    return;
  }, onResume: (msg) {
    print(msg);
    return;
  });
}
