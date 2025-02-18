import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_management/state/user_state/user_model/user_model.dart';
import 'package:task_management/state/user_state/user_repository/user_repository.dart';
import 'package:task_management/state/user_state/user_state.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class User extends _$User {
  User() : super();

  @override
  UserState? build() => UserState.init();

  Future<void> saveUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>('Users');

    UserModelRepository(box).saveUserModel(user);
    return;
  }

  Future<void> getUser(String id) async {
    final box = await Hive.openBox<UserModel>('Users');

    final user = UserModelRepository(box).getUserModel(id);
    if (kDebugMode) {
      print(user);
    }
    return;
  }
}
