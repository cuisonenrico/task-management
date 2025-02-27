import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task_note_model.freezed.dart';
part 'task_note_model.g.dart';

@freezed
class TaskNoteModel with _$TaskNoteModel {
  @HiveType(typeId: 2) // Hive adapter type ID

  const factory TaskNoteModel({
    @HiveField(0) DateTime? createdAt,
    @HiveField(1) String? note,
    @HiveField(2) String? hexColor,
    @HiveField(3) bool? isDone,
  }) = _TaskNoteModel;

  factory TaskNoteModel.fromJson(Map<String, dynamic> json) => _$TaskNoteModelFromJson(json);

  factory TaskNoteModel.init() => const TaskNoteModel(
        createdAt: null,
        note: null,
        hexColor: null,
        isDone: null,
      );
}
