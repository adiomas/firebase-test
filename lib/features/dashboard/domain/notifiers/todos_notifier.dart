import 'package:firebase_test/features/dashboard/data/repositories/todo_repository.dart';
import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_state_notifier.dart';

final todosNotifierProvider =
    StateNotifierProvider.autoDispose<TodosNotifier, BaseState<List<Todo>>>(
  (ref) {
    return TodosNotifier(
      ref.watch(todoRepositoryProvider),
      ref,
    )..getTodosStreamed();
  },
);

class TodosNotifier extends BaseStateNotifier<List<Todo>> {
  final TodoRepository _myChatsRepository;

  TodosNotifier(this._myChatsRepository, super.ref);

  Future getTodosStreamed() {
    return executeStreamed(
      _myChatsRepository.getTodos(),
    );
  }
}
