import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/functions/error_handler_func.dart';
import 'package:qr_user/core/provider/authProvider.dart';
import 'package:qr_user/core/services/dependecyInjection.dart';
import 'package:qr_user/core/validators/validator.dart';
import 'package:qr_user/screens/allScreens.dart';
import 'package:qr_user/screens/loginScreen.dart';
import 'package:qr_user/widgets/customRectBtn.dart';
import 'package:qr_user/widgets/customTextFormField.dart';

class UserRegistorScreen extends StatefulWidget {
  static const routeName = "/user-registor";

  @override
  _UserRegistorScreenState createState() => _UserRegistorScreenState();
}

bool _isLoading = false;

class _UserRegistorScreenState extends State<UserRegistorScreen> {
  @override
  Widget build(BuildContext context) {
    Validators _validators = locator<Validators>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
        GlobalKey<ScaffoldMessengerState>();
    final _passwordController = TextEditingController();
    Map<String, String> _authData = {
      'email': '',
      'password': '',
    };

    //? to be given in signup func for error handling

    // ScaffoldMessenger.of(context)
    //         .showSnackBar(const SnackBar(content: Text("Email Exists")));

    Future<void> _signup() async {
      if (!_formKey.currentState.validate()) return null;
      _formKey.currentState.save();

      setState(() => _isLoading = true);
      try {
        final _authProvider = Provider.of<AuthProvider>(context, listen: false);
        await _authProvider.signup(
            email: _authData["email"], password: _authData["password"]);
        // .catchError(erorHandler);
        setState(() => _isLoading = false);
        Navigator.pushReplacementNamed(context, Userhome.routeName);
      } catch (e) {
        setState(() => _isLoading = false);
        errorHandler(e, _scaffoldKey, context);
      }
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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
                    //! controller used
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      label: "Enter password",
                      controller: _passwordController,
                      onSaved: (value) {
                        _authData["password"] = value;
                      },
                      validators: _validators.passwordValidator,
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      label: "Confirm password",
                      onSaved: (_) {},
                      // ignore: missing_return
                      validators: (value) {
                        if (value.isEmpty) {
                          return "Please fill the field";
                        }
                        if (value != _passwordController.text) {
                          return "Passwords not matching";
                        }
                      },
                    )
                  ],
                )),
            const SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : CustomRectangularBtn(
                    color: Theme.of(context).primaryColor,
                    onPressed: _signup,
                    title: "SIGNUP",
                  ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Back to Login",
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  )),
            )
          ],
        ),
      )),
    );
  }
}
