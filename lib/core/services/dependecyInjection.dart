import 'package:get_it/get_it.dart';
import 'package:qr_user/core/databases/userDetailsdatabase.dart';
import 'package:qr_user/core/databases/userLoginDatabase.dart';
import 'package:qr_user/core/validators/validator.dart';

import 'dio_serices_API.dart';

GetIt locator = GetIt.instance;

void serviceLocators() {
  locator.registerLazySingleton<DioAPIServices>(() => DioAPIServices());
  locator.registerLazySingleton<Validators>(() => Validators());
  locator.registerLazySingleton<UserDatabase>(() => UserDatabase());
  locator
      .registerLazySingleton<UserDetailsDatabase>(() => UserDetailsDatabase());
}
