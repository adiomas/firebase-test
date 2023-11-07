import 'package:firebase_test/common/utils/converters/date_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  @JsonSerializable(explicitToJson: true)
  const factory Todo({
    String? id,
    required String userId,
    String? title,
    String? description,
    required bool isCompleted,
    @DateConverter() required DateTime createdAt,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
