import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  @HiveType(typeId: 0) // Hive adapter type ID

  const factory UserModel({
    @HiveField(0) String? uid, // primary key
    @HiveField(1) String? email,
    @HiveField(2) String? firstName,
    @HiveField(3) String? lastName,
    @HiveField(4) String? username,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.init() => const UserModel(
        uid: null,
        email: null,
        firstName: null,
        lastName: null,
        username: null,
      );
}
