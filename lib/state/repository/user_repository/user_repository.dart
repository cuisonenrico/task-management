import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:task_management/state/user_state/user_model/user_model.dart';

abstract class IUserModelRepository {
  Future<void> saveUserModel(UserModel userModel);
  UserModel? getUserModel(String id);
}

@LazySingleton(as: IUserModelRepository)
class UserModelRepository implements IUserModelRepository {
  final Box<UserModel> _userModelBox;

  UserModelRepository(this._userModelBox);

  @override
  Future<void> saveUserModel(UserModel userModel) async {
    await _userModelBox.put(userModel.uid, userModel);
  }

  @override
  UserModel? getUserModel(String id) {
    return _userModelBox.get(id);
  }
}
