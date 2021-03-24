import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/functions/error_handler_func.dart';
import 'package:qr_user/core/provider/authProvider.dart';
import 'package:qr_user/core/services/dependecyInjection.dart';
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

bool _isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Validators _validators = locator<Validators>();
    final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
        GlobalKey<ScaffoldMessengerState>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    Map<String, String> _authData = {
      'email': '',
      'password': '',
    };
    void erorHandler(e) {
      errorHandler(e, _scaffoldKey, context);
    }

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
        erorHandler(e);
      }
    }

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
