import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/functions/error_handler_func.dart';
import 'package:qr_user/core/provider/authProvider.dart';
import 'package:qr_user/core/services/dependecyInjection.dart';
import 'package:qr_user/core/validators/validator.dart';
import 'package:qr_user/screens/adminLogin.dart';
import 'package:qr_user/screens/allScreens.dart';
import 'package:qr_user/screens/loginScreen.dart';
import 'package:qr_user/widgets/customRectBtn.dart';
import 'package:qr_user/widgets/customTextFormField.dart';

class AdminRegistorScreen extends StatefulWidget {
  static const routeName = "/admin-registor";

  @override
  _UserRegistorScreenState createState() => _UserRegistorScreenState();
}

bool _isLoading = false;

class _UserRegistorScreenState extends State<AdminRegistorScreen> {
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
    // void erorHandler(e) {
    //   errorHandler(e, _scaffoldKey, context);
    // }

    // ScaffoldMessenger.of(context)
    //         .showSnackBar(const SnackBar(content: Text("Email Exists")));

    Future<void> registor() async {
      if (!_formKey.currentState.validate()) return;
      _formKey.currentState.save();

      Provider.of<AuthProvider>(context, listen: false).adminSingup(
          email: _authData["email"], password: _authData["password"]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Registor"),
      ),
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
                    )
                  ],
                )),
            const SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : CustomRectangularBtn(
                    color: Theme.of(context).primaryColor,
                    onPressed: registor,
                    title: "SIGNUP",
                  ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, AdminLoginScreen.routeName);
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
