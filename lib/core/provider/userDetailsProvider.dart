import 'package:flutter/material.dart';
import 'package:qr_user/core/databases/userDetailsdatabase.dart';
import 'package:qr_user/core/models/user_details_model.dart';
import 'package:qr_user/core/services/dependecyInjection.dart';

class UserdetailsProvider with ChangeNotifier {
  UserDetailsModel _userDetailsData;
  UserDetailsDatabase _userDetailsDatabase = locator<UserDetailsDatabase>();
  // List<UserDetailsModel> _items = [];

  // List<UserDetailsModel> get items {
  //   return [..._items];
  // }

  // UserDetailsModel findById(String id) {
  //   return _items.firstWhere((prod) => prod.id == id);
  // }

  // void addDetails(UserDetailsModel userDetails) {
  //   final newUser = UserDetailsModel(
  //       id: DateTime.now().toString(),
  //       name: userDetails.name,
  //       address: userDetails.address,
  //       phoneNumber: userDetails.phoneNumber);
  //   _items.add(newUser);
  //   notifyListeners();
  // }

  // void updateProduct(String id, UserDetailsModel newProduct) {
  //   final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     _items[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {
  //     print('...');
  //   }
  // }

  UserDetailsModel get userDetailsData => _userDetailsData;

  Future<void> _userDetailsDatabaseSave(UserDetailsModel data) async {
    _userDetailsDatabase.addData(data);
  }

  bool get isDetailsEntered => _userDetailsData == null
      ? false
      : _userDetailsData.name == null
          ? false
          : true;

  void accessDetails() {
    UserDetailsModel _temp = _userDetailsDatabase.acessData();
    if (_temp != null) _userDetailsData = _temp;
  }

  void addDetails(UserDetailsModel userDetails) {
    final newUser = UserDetailsModel(
        id: DateTime.now().toString(),
        address: userDetails.address,
        name: userDetails.name,
        phoneNumber: userDetails.phoneNumber);

    _userDetailsData = UserDetailsModel.convert(newUser);
    _userDetailsDatabaseSave(_userDetailsData);
    notifyListeners();
  }
}
