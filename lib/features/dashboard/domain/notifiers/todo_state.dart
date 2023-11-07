import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState({
    required Todo todo,
  }) = _TodoState;
}
