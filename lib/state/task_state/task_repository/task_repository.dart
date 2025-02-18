import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:task_management/state/task_state/task_model/task_model.dart';

abstract class ITaskRepository {
  Future<void> saveTask(TaskModel task);
  Future<List<TaskModel>?> getTasks();
}

@LazySingleton(as: ITaskRepository)
class TaskRepository implements ITaskRepository {
  final Box<TaskModel> _taskBox;

  TaskRepository(this._taskBox);

  @override
  Future<void> saveTask(TaskModel task) async {
    try {
      await _taskBox.put(task.id, task);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>?> getTasks() async => _taskBox.values.toList();
}
