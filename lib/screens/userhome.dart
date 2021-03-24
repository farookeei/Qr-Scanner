import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/functions/error_handler_func.dart';
import 'package:qr_user/core/provider/authProvider.dart';
import 'package:qr_user/core/provider/userDetailsProvider.dart';
import 'package:qr_user/screens/allScreens.dart';
import 'package:qr_user/screens/loginScreen.dart';
import 'package:qr_user/screens/userDetailsEditScreen.dart';
import 'package:qr_user/screens/userDetailsScreen.dart';
import 'package:qr_user/widgets/customRectBtn.dart';

class Userhome extends StatelessWidget {
  final String id;
  Userhome({this.id});

  static const routeName = "/user-home";

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

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
            Text("Welcome User", style: Theme.of(context).textTheme.headline5),
            Image.asset("assets/images/userhome.png"),
            CustomRectangularBtn(
              color: Colors.grey,
              onPressed: () {
                Navigator.pushNamed(context, UserDetailsScreen.routeName);
              },
              verticalPadding: 15,
              title: "Enter personal details",
            ),
            const SizedBox(height: 10),
            Consumer<UserdetailsProvider>(
              builder: (ctx, _details, _) {
                _details.accessDetails();
                return _details.isDetailsEntered
                    ? CustomRectangularBtn(
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            UserDetailsEditScreen.routeName,
                          );
                        },
                        verticalPadding: 15,
                        title: "Update Personal details",
                      )
                    : CustomRectangularBtn(
                        color: Colors.grey,
                        onPressed: () {
                          errorHandler("Enter Details before editing",
                              _scaffoldKey, context);
                        },
                        title: "Update Personal details",
                        verticalPadding: 15,
                      );
              },
            ),
            const SizedBox(height: 10),
            Consumer<UserdetailsProvider>(
              builder: (ctx, _details, _) {
                _details.accessDetails();
                return _details.isDetailsEntered
                    ? CustomRectangularBtn(
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(GeneratePage.routeName);
                        },
                        verticalPadding: 15,
                        title: "Generate Qr code",
                      )
                    : CustomRectangularBtn(
                        color: Colors.grey,
                        onPressed: () {
                          errorHandler("Enter Details before generating",
                              _scaffoldKey, context);
                        },
                        title: "Generate Qr Code",
                        verticalPadding: 15,
                      );
              },
            ),
            const SizedBox(height: 10),
            CustomRectangularBtn(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
