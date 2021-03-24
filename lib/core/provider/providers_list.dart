import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:qr_user/core/provider/authProvider.dart';
import 'package:qr_user/core/provider/userDetailsProvider.dart';

List<SingleChildWidget> providers() => [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => UserdetailsProvider())
    ];
