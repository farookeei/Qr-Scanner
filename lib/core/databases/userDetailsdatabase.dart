import 'package:hive/hive.dart';
import 'package:qr_user/core/models/user_details_model.dart';

class UserDetailsDatabase {
  static const boxname = 'userDetails';

  Future<void> addData(UserDetailsModel data) async {
    final _userBox = Hive.box(boxname);
    if (_userBox.isNotEmpty) _userBox.clear();
    await _userBox.add(data);
  }

  UserDetailsModel acessData() {
    final _userBox = Hive.box(boxname);
    if (_userBox.isEmpty) return null;
    return _userBox.getAt(0);
  }

  void deleteData() {
    final _userBox = Hive.box(boxname);
    _userBox.clear();
  }
}
