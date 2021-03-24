import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_user/core/databases/userDetailsdatabase.dart';
import 'package:qr_user/core/databases/userLoginDatabase.dart';
import 'package:qr_user/core/error/http_exception.dart';
import 'package:qr_user/core/models/user_model.dart';
import 'package:qr_user/core/services/dependecyInjection.dart';
import 'package:qr_user/core/services/dio_serices_API.dart';
import 'package:qr_user/core/services/firebase_cloud_storage.dart';
import 'package:qr_user/core/services/firebaseauth.dart';

class AuthProvider with ChangeNotifier {
  DioAPIServices _dioAPIServices = locator<DioAPIServices>();
  UserModel _userData;
  //!Login
  UserDatabase _userdatabase = locator<UserDatabase>();
  UserDetailsDatabase _userDetailsDatabase = locator<UserDetailsDatabase>();
  FirebaseAuthEmail _firebaseAuthEmail = locator<FirebaseAuthEmail>();
  FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();
  FirebaseCloudStorageServices _cloudStorage =
      locator<FirebaseCloudStorageServices>();

  bool get isUserSigned => _firebaseAuth.currentUser == null
      ? false
      : _userData == null
          ? false
          : true;

  bool get isUserAdmin => _userData.isAdmin == null ? false : _userData.isAdmin;

  UserModel get userData => _userData;

  Future<void> _userDataSave(UserModel data) async {
    _userdatabase.addData(data);
  }

  void accessUserData() {
    UserModel _temp = _userdatabase.acessData();
    if (_temp != null) _userData = _temp;
  }

  Future<void> signup({String email, String password}) async {
    try {
      User _user = await _firebaseAuthEmail.emailAndPasswordSignUp(
          email: email, password: password);
      UserModel _userDataTemp =
          UserModel(emal: email, password: password, isAdmin: false);

      _userData = _userDataTemp;
      notifyListeners();
      _userDataSave(_userDataTemp);
    } catch (e) {
      throw e;
    }
  }

  Future<void> login({String email, String password}) async {
    try {
      User _user = await _firebaseAuthEmail.emailAndPasswordSignIn(
          email: email, password: password);
      UserModel _userDataTemp =
          UserModel(emal: email, password: password, isAdmin: false);

      _userData = _userDataTemp;
      notifyListeners();
      _userDataSave(_userDataTemp);
    } catch (e) {
      throw e;
    }
  }

  Future<void> adminLogin(
      {@required String email, @required String password}) async {
    try {
      print("sdf");
      User _user = await _firebaseAuthEmail.emailAndPasswordSignIn(
          email: email, password: password);

      UserModel _userDataTemp =
          UserModel(emal: email, password: password, isAdmin: false);

      _userData = _userDataTemp;
      notifyListeners();
      _userDataSave(_userDataTemp);
    } catch (e) {
      throw e;
    }
  }

  Future<void> adminSingup(
      {@required String email, @required String password}) async {
    try {
      User _user = await _firebaseAuthEmail.emailAndPasswordSignUp(
          email: email, password: password);

      UserModel _userDataTemp =
          UserModel(emal: email, password: password, isAdmin: false);

      _userData = _userDataTemp;
      notifyListeners();
      _userDataSave(_userDataTemp);
    } catch (e) {
      throw e;
    }
  }

  void logout() async {
    _userdatabase.deleteData();
    _userDetailsDatabase.deleteData();
    await _firebaseAuthEmail.logout();
    notifyListeners();
  }

  Future<void> saveData({@required Map data}) async {
    try {
      await _cloudStorage.addData(email: _userData.emal, data: data);
    } catch (e) {
      throw e;
    }
  }

  Future<List<Map>> acessData() async {
    try {
      final List<Map> _data =
          await _cloudStorage.getData(email: _userData.emal);
      return _data;
    } catch (e) {
      throw e;
    }
  }
}
