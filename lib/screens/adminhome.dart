import 'package:flutter/material.dart';
import 'package:qr_user/screens/scanQr.dart';

import 'package:qr_user/widgets/customRectBtn.dart';

class AdminHome extends StatelessWidget {
  static const routeName = "/admin-home";

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
            CustomRectangularBtn(
              color: Colors.grey,
              onPressed: () {},
              verticalPadding: 15,
              title: "Upload scanned details",
            ),
            const SizedBox(height: 10),
            CustomRectangularBtn(
              color: Colors.grey,
              onPressed: () {},
              verticalPadding: 15,
              title: "Manage details",
            ),
            const SizedBox(height: 10),
            CustomRectangularBtn(
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              verticalPadding: 20,
              title: "LOGOUT",
            )
          ],
        ),
      )),
    );
  }
}
