import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String token;
  @HiveField(1)
  final DateTime expiryDate;
  @HiveField(2)
  final String userId;

  UserModel({this.expiryDate, this.userId, this.token});

  static UserModel convert(Map data) {
    return UserModel(
        token: data["idToken"],
        userId: data["localId"],
        expiryDate: DateTime.now()
            .add(Duration(seconds: int.parse(data["expiresIn"]))));
  }
}
