import 'package:flutter/material.dart';
import 'package:qr_user/core/databases/userDetailsdatabase.dart';
import 'package:qr_user/core/databases/userLoginDatabase.dart';
import 'package:qr_user/core/error/http_exception.dart';
import 'package:qr_user/core/models/user_model.dart';
import 'package:qr_user/core/services/dependecyInjection.dart';
import 'package:qr_user/core/services/dio_serices_API.dart';

class AuthProvider with ChangeNotifier {
  DioAPIServices _dioAPIServices = locator<DioAPIServices>();
  UserModel _userData;
//!Login
  UserDatabase _userdatabase = locator<UserDatabase>();
  UserDetailsDatabase _userDetailsDatabase = locator<UserDetailsDatabase>();
// AIzaSyBYHctAVCf7hdZMkWJaAfjZnnZnugn9mss

  bool get isUserSigned => _userData == null
      ? false
      : _userData.token == null
          ? false
          : true;

  UserModel get userData => _userData;

  Future<void> _userDataSave(UserModel data) async {
    _userdatabase.addData(data);
  }

  void accessUserData() {
    UserModel _temp = _userdatabase.acessData();
    if (_temp != null) _userData = _temp;
  }

  Future<void> signup({String email, String password}) async {
    Map _body = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };
    try {
      final _fetchData = await _dioAPIServices.postAPI(
          url: "signUp?key=AIzaSyBYHctAVCf7hdZMkWJaAfjZnnZnugn9mss",
          body: _body);
      print(_fetchData);
      _userData = UserModel.convert(_fetchData);
      _userDataSave(_userData);
      // if(_fetchData["error"]! = null){
      //   throw HttpException(_fetchData["error"]["message"], 400);
      // }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> login({String email, String password}) async {
    Map _body = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };
    try {
      final _fetchData = await _dioAPIServices.postAPI(
          url: "signInWithPassword?key=AIzaSyBYHctAVCf7hdZMkWJaAfjZnnZnugn9mss",
          body: _body);
      print(_fetchData);
      _userData = UserModel.convert(_fetchData);
      _userDataSave(_userData);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Future<void> adminLogin() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  // }

  void logout() {
    _userdatabase.deleteData();
    _userDetailsDatabase.deleteData();
  }
}
