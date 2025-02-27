import 'package:task_management/state/task_state/task_model/task_model.dart';

abstract class ITaskRepository {
  Future<void> saveTask(TaskModel task);
  Future<List<TaskModel>?> getTasks();
}
