// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

import '../../state/task_state/task_model/task_model.dart' as _i589;
import '../../state/task_state/task_repository/task_repository.dart' as _i38;
import '../../state/user_state/user_model/user_model.dart' as _i617;
import '../../state/user_state/user_repository/user_repository.dart' as _i351;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i351.IUserModelRepository>(
        () => _i351.UserModelRepository(gh<_i979.Box<_i617.UserModel>>()));
    gh.lazySingleton<_i38.ITaskRepository>(
        () => _i38.TaskRepository(gh<_i979.Box<_i589.TaskModel>>()));
    return this;
  }
}
