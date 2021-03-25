import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/functions/error_handler_func.dart';
import 'package:qr_user/core/provider/authProvider.dart';
import 'package:qr_user/core/services/dependecyInjection.dart';
import 'package:qr_user/core/services/google_sigin.dart';
import 'package:qr_user/core/validators/validator.dart';
import 'package:qr_user/screens/adminhome.dart';
import 'package:qr_user/screens/adminregistor.dart';
import 'package:qr_user/screens/allScreens.dart';
import 'package:qr_user/widgets/customRectBtn.dart';
import 'package:qr_user/widgets/customTextFormField.dart';

class AdminLoginScreen extends StatefulWidget {
  static const routeName = "/admin-login";
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

bool _isLoading = false;

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  Validators _validators = locator<Validators>();
  bool _isGoogleLoading = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  FirebaseGoogleAuthServices _googleAuthServices =
      locator<FirebaseGoogleAuthServices>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  Future<void> login() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    setState(() => _isLoading = true);

    try {
      final _authProvider = Provider.of<AuthProvider>(context, listen: false);

      await _authProvider.adminLogin(
          email: _authData['email'], password: _authData['password']);

      // if (_authProvider.isUserAdmin) {
      //   Navigator.pushReplacementNamed(context, AdminHome.routeName);
      // }

      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, AdminHome.routeName);
    } catch (e) {
      setState(() => _isLoading = false);
      errorHandler(e, _scaffoldKey, context);
      print(e);
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
          .googleSigin(isAdmin: true, email: _user.email);

      setState(() => _isGoogleLoading = false);
      Navigator.pushReplacementNamed(context, AdminHome.routeName);
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
            Image.asset("assets/images/adminLogin.png"),
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
                    color: Theme.of(context).accentColor,
                    onPressed: login,
                    title: "LOGIN",
                  ),
            const SizedBox(height: 20),
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
                    context, AdminRegistorScreen.routeName);
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
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Text(
                "Go to User Login",
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
