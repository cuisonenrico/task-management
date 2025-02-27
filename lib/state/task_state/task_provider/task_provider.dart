import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_management/state/task_state/task_model/task_model.dart';
import 'package:task_management/state/task_state/task_repository/i_task_repository.dart';
import 'package:task_management/state/task_state/task_repository/task_repository.dart';
import 'package:task_management/state/task_state/task_state.dart';

part 'task_provider.g.dart';

@Riverpod(keepAlive: true)
class Task extends _$Task implements ITaskRepository {
  Task() : super();

  @override
  TaskState? build() => TaskState.init();

  @override
  Future<void> saveTask(TaskModel task) async {
    final box = await Hive.openBox<TaskModel>('Tasks');

    TaskRepository(box).saveTask(task);
    final tasks = state?.tasks;
    if (tasks == null || tasks.isEmpty) return;
    state = state?.copyWith(tasks: [
      ...tasks,
      ...[task]
    ]);

    return;
  }

  @override
  Future<List<TaskModel>?> getTasks() async {
    final box = await Hive.openBox<TaskModel>('Tasks');

    final tasks = await TaskRepository(box).getTasks();
    if (kDebugMode) {
      print(tasks);
    }
    state = state?.copyWith(tasks: tasks);
    return tasks;
  }
}
