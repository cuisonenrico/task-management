import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_management/state/task_state/task_model/task_model.dart';

part 'task_state.freezed.dart';
part 'task_state.g.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState({
    @Default([]) List<TaskModel>? tasks,
  }) = _TaskState;

  factory TaskState.fromJson(Map<String, dynamic> json) => _$TaskStateFromJson(json);

  factory TaskState.init() => TaskState(
        tasks: List.empty(),
      );
}
