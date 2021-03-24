import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String emal;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final bool isAdmin;

  UserModel(
      {@required this.emal, @required this.password, @required this.isAdmin});
}
