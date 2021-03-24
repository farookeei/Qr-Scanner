import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'dependecyInjection.dart';

class FirebaseCloudStorageServices {
  FirebaseFirestore _firebaseAuth = locator<FirebaseFirestore>();

  Future<void> addData({@required String email, @required Map data}) async {
    try {
      await _firebaseAuth
          .collection('usersDetails')
          .doc(email)
          .collection("full_details")
          .add(data);
    } catch (e) {
      throw e;
    }
  }

  Future<List<Map>> getData({@required String email}) async {
    try {
      QuerySnapshot _data = await _firebaseAuth
          .collection('usersDetails')
          .doc(email)
          .collection("full_details")
          .get();

      List<Map> _userData = [];

      _data.docs.forEach((element) {
        _userData.add(element.data());
      });

      return _userData;
    } catch (e) {
      throw e;
    }
  }
}
