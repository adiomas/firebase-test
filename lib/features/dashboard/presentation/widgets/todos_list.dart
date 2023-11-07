import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';
import 'package:firebase_test/features/dashboard/presentation/widgets/checkbox_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodosList extends ConsumerWidget {
  final List<Todo> todos;
  const TodosList({super.key, required this.todos});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: todos.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.borderRadius16),
      itemBuilder: (context, index) => CheckBoxListTile(
        todo: todos[index],
      ),
    );
  }
}
