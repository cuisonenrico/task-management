import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:task_management/state/task_state/task_note_model/task_note_model.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  @HiveType(typeId: 1) // Hive adapter type ID

  const factory TaskModel({
    @HiveField(0) String? id, // primary key
    @HiveField(1) DateTime? createdAt,
    @HiveField(2) DateTime? deadlineAt,
    @HiveField(3) String? title,
    @HiveField(4) String? hexColor,
    @HiveField(5) String? description,
    @HiveField(6) bool? isPriority,
    @HiveField(7) bool? isAllDay,
    @HiveField(8) bool? isDone,
    @HiveField(9) List<TaskNoteModel>? taskNotes,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  factory TaskModel.init() => TaskModel(
        id: null,
        createdAt: null,
        deadlineAt: null,
        title: null,
        hexColor: null,
        description: null,
        isAllDay: null,
        isPriority: null,
        isDone: null,
        taskNotes: List.empty(),
      );
}
