import 'dart:math';

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
import 'package:qr_user/core/services/google_sigin.dart';

class AuthProvider with ChangeNotifier {
  DioAPIServices _dioAPIServices = locator<DioAPIServices>();
  UserModel _userData;
  List<Map> _usersFetchedData = [];
  //!Login
  UserDatabase _userdatabase = locator<UserDatabase>();
  UserDetailsDatabase _userDetailsDatabase = locator<UserDetailsDatabase>();
  FirebaseAuthEmail _firebaseAuthEmail = locator<FirebaseAuthEmail>();
  FirebaseGoogleAuthServices _googleSignIns =
      locator<FirebaseGoogleAuthServices>();
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

  List<Map> get userFetchedData => _usersFetchedData;

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
          UserModel(emal: email, password: password, isAdmin: true);

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
          UserModel(emal: email, password: password, isAdmin: true);

      _userData = _userDataTemp;
      notifyListeners();
      _userDataSave(_userDataTemp);
    } catch (e) {
      throw e;
    }
  }

  //? TODO
  Future<void> googleSigin({String token, String email, bool isAdmin}) async {
    try {
      // Map _data = {'token': token, 'email': email};

      // final _fetchgData = await _dioAPIServices
      //     .postAPI(url: 'externalsigin/google', body: _data)
      //     .toString();
      //!fdfdfv

      await _googleSignIns.signIn();
      // print(_fetchgData);
      UserModel _userDataTemp =
          UserModel(emal: email, password: '', isAdmin: isAdmin);

      _userData = _userDataTemp;

      // _userDatabase.addData(_userData);

      notifyListeners();
      _userDataSave(_userDataTemp);
    } catch (e) {
      throw e;
    }
  }

  //! google signout added
  Future<void> logout() async {
    _userdatabase.deleteData();
    _userDetailsDatabase.deleteData();
    await _firebaseAuthEmail.logout();
    await _googleSignIns.signout();
    notifyListeners();
  }

  //!user details
  Future<void> saveData({@required Map data}) async {
    try {
      await _cloudStorage.addData(email: _userData.emal, data: data);
    } catch (e) {
      throw e;
    }
  }

  //!userdetails
  Future<List<Map>> acessData() async {
    try {
      _usersFetchedData = await _cloudStorage.getData(email: _userData.emal);
      return _usersFetchedData;
    } catch (e) {
      throw e;
    }
  }
}
