import 'package:hive/hive.dart';

part 'user_details_model.g.dart';

@HiveType(typeId: 2)
class UserDetailsModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int phoneNumber;
  @HiveField(3)
  final String address;

  UserDetailsModel({this.id, this.address, this.name, this.phoneNumber});

  static UserDetailsModel convert(UserDetailsModel data) {
    return UserDetailsModel(
        id: data.id,
        address: data.address,
        name: data.name,
        phoneNumber: data.phoneNumber);
  }
}
