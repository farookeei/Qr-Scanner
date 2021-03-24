import 'package:hive/hive.dart';
import 'package:qr_user/core/models/user_model.dart';

class UserDatabase {
  static const boxname = 'userLoginData';

  Future<void> addData(UserModel data) async {
    final _userBox = Hive.box(boxname);
    if (_userBox.isNotEmpty) _userBox.clear();
    await _userBox.add(data);
  }

  UserModel acessData() {
    final _userBox = Hive.box(boxname);
    if (_userBox.isEmpty) return null;
    return _userBox.getAt(0);
  }

  void deleteData() {
    final _userBox = Hive.box(boxname);
    _userBox.clear();
  }
}
