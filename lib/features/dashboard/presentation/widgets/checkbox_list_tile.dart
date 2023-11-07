import 'package:firebase_test/common/presentation/widgets/firebase_test_text.dart';
import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';
import 'package:firebase_test/features/dashboard/domain/notifiers/todo_notifier.dart';
import 'package:firebase_test/features/dashboard/domain/providers.dart';
import 'package:firebase_test/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckBoxListTile extends ConsumerWidget {
  final Todo todo;
  const CheckBoxListTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDeleteIcons = ref.watch(showDeleteProvider);
    return Row(
      children: [
        if (showDeleteIcons)
          Expanded(
            child: IconButton(
              onPressed: () => ref
                  .read(todoNotifierProvider.notifier)
                  .deleteTodo(id: todo.id!),
              icon: const Icon(
                Icons.delete,
                color: CustomColors.alertCritical,
              ),
            ),
          ),
        Expanded(
          flex: 7,
          child: CheckboxListTile(
            value: todo.isCompleted,
            onChanged: (_) => ref
                .read(todoNotifierProvider.notifier)
                .toggleComplete(id: todo.id!, isCompleted: !todo.isCompleted),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ), // Optionally
              side: BorderSide(color: CustomColors.grey500, width: 2.0),
            ),
            fillColor: todo.isCompleted
                ? MaterialStateProperty.resolveWith(
                    (states) => CustomColors.primaryDefault,
                  )
                : null,
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(
                color: CustomColors.grey500,
                width: 1,
              ),
            ),
            title: FirebaseTestText.extraBoldLarge(
              todo.title!,
              context: context,
            ),
            subtitle: todo.description != null
                ? FirebaseTestText.semiBoldSmall(
                    todo.description!,
                    context: context,
                    color: CustomColors.grey900,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
