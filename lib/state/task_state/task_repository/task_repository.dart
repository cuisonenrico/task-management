import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:task_management/state/task_state/task_model/task_model.dart';

abstract class ITaskRepository {
  Future<void> saveTask(TaskModel task);
  List<TaskModel>? getTasks();
}

@LazySingleton(as: ITaskRepository)
class TaskRepository implements ITaskRepository {
  final Box<TaskModel> _taskBox;

  TaskRepository(this._taskBox);

  @override
  Future<void> saveTask(TaskModel task) async => await _taskBox.put(task, task);

  @override
  List<TaskModel>? getTasks() => _taskBox.values.toList();
}
