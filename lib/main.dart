import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/provider/authProvider.dart';
import 'package:qr_user/core/provider/providers_list.dart';
import 'package:qr_user/core/themes/mainThemes.dart';
import 'package:qr_user/routes/routes.dart';
import 'package:qr_user/screens/allScreens.dart';
import 'package:qr_user/screens/wrapper.dart';

import 'core/databases/databaseConfigs.dart';
import 'core/env/env_configs.dart';
import 'core/services/dependecyInjection.dart';

void main() async {
  envConfig();
  serviceLocators();
  WidgetsFlutterBinding.ensureInitialized();
  await hiveInitalSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: providers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themes(),
        home: Consumer<AuthProvider>(
          builder: (ctx, _authProvider, _) {
            _authProvider.accessUserData();
            return _authProvider.isUserSigned ? Userhome() : LoginScreen();
          },
        ),
        routes: routes(),
      ),
    );
  }
}
