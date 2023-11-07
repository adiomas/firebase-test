import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:firebase_test/features/dashboard/domain/notifiers/todos_notifier.dart';
import 'package:firebase_test/features/dashboard/domain/providers.dart';
import 'package:firebase_test/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:firebase_test/features/dashboard/presentation/widgets/tab_bar_todo.dart';
import 'package:firebase_test/features/dashboard/presentation/widgets/todos_list.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_state_notifier.dart';

class DashboardPage extends ConsumerWidget {
  static const routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosState = ref.watch(todosNotifierProvider);

    return switch (todosState) {
      BaseData(data: final data) => Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DashBoardHeader(),
              const SizedBox(height: AppSizes.borderRadius16),
              const TabBarTodo(),
              const SizedBox(height: AppSizes.borderRadius16),
              Expanded(
                child: TodosList(
                  todos: ref.watch(
                    filterTodosProvider(data),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.borderRadius16),
            ],
          ),
        ),
      _ => const SizedBox(),
    };
  }
}
