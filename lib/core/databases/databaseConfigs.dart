import 'package:hive/hive.dart';
import 'package:qr_user/core/databases/userDetailsdatabase.dart';
import 'package:qr_user/core/databases/userLoginDatabase.dart';
import 'package:path_provider/path_provider.dart' as path_Provider;
import 'package:qr_user/core/models/user_details_model.dart';
import 'package:qr_user/core/models/user_model.dart';

hiveInitalSetup() async {
  final appDocumnetDirectory =
      await path_Provider.getApplicationDocumentsDirectory();

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(UserDetailsModelAdapter());

  // Hive.registerAdapter(UserTypeAdapter());

  Hive.init(appDocumnetDirectory.path);

  await Hive.openBox(UserDatabase.boxname);
  await Hive.openBox(UserDetailsDatabase.boxname);
}
