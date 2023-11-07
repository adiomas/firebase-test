import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';
import 'package:firebase_test/features/dashboard/presentation/widgets/tab_bar_todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedTabProvider = StateProvider<TodoTabs>((ref) => TodoTabs.all);

final filterTodosProvider = StateProvider.family<List<Todo>, List<Todo>>(
  (ref, todos) {
    final selectedTab = ref.watch(selectedTabProvider);
    if (selectedTab == TodoTabs.all) return todos;
    if (selectedTab == TodoTabs.completed) {
      return todos.where((todo) => todo.isCompleted).toList();
    } else {
      return todos.where((todo) => !todo.isCompleted).toList();
    }
  },
);

final showDeleteProvider = StateProvider<bool>((ref) => false);
