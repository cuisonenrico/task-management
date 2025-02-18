import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_management/state/task_state/task_model/task_model.dart';
import 'package:task_management/state/task_state/task_repository/task_repository.dart';
import 'package:task_management/state/task_state/task_state.dart';

part 'task_provider.g.dart';

@Riverpod(keepAlive: true)
class Task extends _$Task {
  Task() : super();

  @override
  TaskState? build() => TaskState.init();

  Future<void> saveTask(TaskModel task) async {
    final box = await Hive.openBox<TaskModel>('Tasks');

    TaskRepository(box).saveTask(task);
    return;
  }

  Future<void> getTask(String id) async {
    final box = await Hive.openBox<TaskModel>('Tasks');

    final task = TaskRepository(box).getTasks();
    if (kDebugMode) {
      print(task);
    }
    return;
  }
}
