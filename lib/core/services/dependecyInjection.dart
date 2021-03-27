import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_user/core/databases/userDetailsdatabase.dart';
import 'package:qr_user/core/databases/userLoginDatabase.dart';
import 'package:qr_user/core/validators/validator.dart';

import 'dio_serices_API.dart';
import 'firebase_cloud_storage.dart';

import 'firebaseauth.dart';
import 'google_sigin.dart';

GetIt locator = GetIt.instance;

void serviceLocators() {
  locator.registerLazySingleton<DioAPIServices>(() => DioAPIServices());
  locator.registerLazySingleton<Validators>(() => Validators());
  locator.registerLazySingleton<UserDatabase>(() => UserDatabase());
  locator
      .registerLazySingleton<UserDetailsDatabase>(() => UserDetailsDatabase());
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseAuthEmail>(() => FirebaseAuthEmail());
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  locator.registerLazySingleton<FirebaseCloudStorageServices>(
      () => FirebaseCloudStorageServices());
  locator.registerLazySingleton<FirebaseGoogleAuthServices>(
      () => FirebaseGoogleAuthServices());
}
