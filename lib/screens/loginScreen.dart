import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/functions/error_handler_func.dart';
import 'package:qr_user/core/provider/authProvider.dart';
import 'package:qr_user/core/services/dependecyInjection.dart';
import 'package:qr_user/core/services/google_sigin.dart';
import 'package:qr_user/core/validators/validator.dart';
import 'package:qr_user/screens/adminLogin.dart';
import 'package:qr_user/screens/allScreens.dart';
import 'package:qr_user/screens/generate_qr.dart';
import 'package:qr_user/screens/user_registor.dart';
import 'package:qr_user/screens/userhome.dart';
import 'package:qr_user/widgets/customRectBtn.dart';
import 'package:qr_user/widgets/customTextFormField.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  Validators _validators = locator<Validators>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  FirebaseGoogleAuthServices _googleAuthServices =
      locator<FirebaseGoogleAuthServices>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  Future<void> _login() async {
    if (!_formKey.currentState.validate()) return null;
    _formKey.currentState.save();

    setState(() => _isLoading = true);

    try {
      final _authProvider = Provider.of<AuthProvider>(context, listen: false);
      await _authProvider.login(
          email: _authData["email"], password: _authData["password"]);

      setState(() => _isLoading = false);
      Navigator.of(context).pushReplacementNamed(Userhome.routeName);
    } catch (e) {
      setState(() => _isLoading = false);
      errorHandler(e, _scaffoldKey, context);
    }
  }

  Future<void> googleSignin() async {
    setState(() => _isGoogleLoading = true);

    try {
      User _user = await _googleAuthServices.signIn();
      if (_user == null) return null;

      // String _idToken = await _user.getIdToken();

      // await Provider.of<AuthProvider>(context, listen: false)
      //     .googleSigin(email: _user.email, token: _idToken);
      await Provider.of<AuthProvider>(context, listen: false)
          .googleSigin(isAdmin: false, email: _user.email);

      setState(() => _isGoogleLoading = false);
      Navigator.pushReplacementNamed(context, Userhome.routeName);
    } catch (e) {
      setState(() => _isGoogleLoading = false);
      errorHandler(e, _scaffoldKey, context);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/login.png"),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      label: "Enter email",
                      validators: _validators.emailValidator,
                      onSaved: (value) {
                        _authData["email"] = value;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      label: "Enter password",
                      validators: _validators.passwordValidator,
                      onSaved: (value) {
                        _authData["password"] = value;
                      },
                    )
                  ],
                )),
            const SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : CustomRectangularBtn(
                    color: Theme.of(context).primaryColor,
                    onPressed: _login,
                    title: "LOGIN",
                  ),
            _isGoogleLoading
                ? CircularProgressIndicator()
                : GestureDetector(
                    onTap: googleSignin,
                    child: Image.asset(
                      "assets/images/google.png",
                      scale: 1.5,
                    ),
                  ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, UserRegistorScreen.routeName);
              },
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "New here?Register now",
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      )),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, AdminLoginScreen.routeName);
              },
              child: Text(
                "Go to Admin Login",
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
