import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  @HiveType(typeId: 1) // Hive adapter type ID

  const factory TaskModel({
    @HiveField(0) String? id, // primary key
    @HiveField(1) DateTime? date,
    @HiveField(2) String? title,
    @HiveField(3) String? description,
    @HiveField(5) bool? isPriority,
    @HiveField(6) bool? isAllDay,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  factory TaskModel.init() => const TaskModel(
        id: null,
        date: null,
        title: null,
        description: null,
        isAllDay: null,
        isPriority: null,
      );
}
