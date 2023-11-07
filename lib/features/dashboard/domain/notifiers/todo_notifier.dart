import 'package:firebase_test/features/dashboard/data/repositories/todo_repository.dart';
import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';
import 'package:firebase_test/features/dashboard/forms/todo_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final todoNotifierProvider = StateNotifierProvider<TodoNotifier, void>((ref) {
  return TodoNotifier(
    ref.watch(todoRepositoryProvider),
    ref.watch(todoFormMapperProvider),
    ref,
  );
});

class TodoNotifier extends SimpleStateNotifier<void> {
  final TodoRepository _todoRepository;
  final FormMapper<Todo> _todoFormMapper;

  TodoNotifier(
    this._todoRepository,
    this._todoFormMapper,
    Ref ref,
  ) : super(
          ref,
          null,
        );

  Future<void> addTodo({
    required Map<String, dynamic> formMap,
  }) async {
    final todo = _todoFormMapper(formMap);

    final result = await _todoRepository.addTodo(todo: todo);
    result.fold(
      (failure) => setGlobalFailure(failure),
      (_) => null,
    );
  }

  Future<void> toggleComplete({
    required String id,
    required bool isCompleted,
  }) async {
    final result = await _todoRepository.toggleComplete(
      id: id,
      isCompleted: isCompleted,
    );
    result.fold(
      (failure) => setGlobalFailure(failure),
      (_) => null,
    );
  }

  Future<void> deleteTodo({
    required String id,
  }) async {
    final result = await _todoRepository.deleteTodo(
      id: id,
    );
    result.fold(
      (failure) => setGlobalFailure(failure),
      (_) => null,
    );
  }
}
