import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/provider/authProvider.dart';
import 'package:qr_user/screens/adminLogin.dart';
import 'package:qr_user/screens/fetchDetails.dart';
import 'package:qr_user/screens/scanQr.dart';

import 'package:qr_user/widgets/customRectBtn.dart';
import 'package:qr_user/widgets/handlingNotifications.dart';

class AdminHome extends StatefulWidget {
  static const routeName = "/admin-home";

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    super.initState();
    handleNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text("Welcome Administator",
                style: Theme.of(context).textTheme.headline5),
            Image.asset("assets/images/adminhome.png"),
            CustomRectangularBtn(
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pushNamed(ScanPage.routeName);
              },
              verticalPadding: 15,
              title: "Scan QR Code",
            ),
            const SizedBox(height: 10),
            // CustomRectangularBtn(
            //   color: Colors.grey,
            //   onPressed: () {},
            //   verticalPadding: 15,
            //   title: "Upload scanned details",
            // ),

            CustomRectangularBtn(
              color: Colors.grey,
              onPressed: () {
                Navigator.pushNamed(context, FetchDetails.routeName);
              },
              verticalPadding: 15,
              title: "Scanned User details",
            ),
            const SizedBox(height: 10),
            CustomRectangularBtn(
              color: Theme.of(context).accentColor,
              onPressed: () async {
                await Provider.of<AuthProvider>(context, listen: false)
                    .logout();
                Navigator.pushReplacementNamed(
                    context, AdminLoginScreen.routeName);
              },
              verticalPadding: 20,
              title: "LOGOUT",
            )
          ],
        ),
      )),
    );
  }
}
