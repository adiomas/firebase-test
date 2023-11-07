import 'package:firebase_test/common/presentation/widgets/action_button.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_dialog.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_text.dart';
import 'package:firebase_test/features/dashboard/domain/providers.dart';
import 'package:firebase_test/features/dashboard/presentation/widgets/todo_dialog.dart';
import 'package:firebase_test/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashBoardHeader extends ConsumerWidget {
  const DashBoardHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDeleteState = ref.watch(showDeleteProvider);
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 200,
            child: ActionButton.outline(
              onTap: () => FirebaseTestDialog.show(
                context,
                withCloseButton: true,
                child: const TodoDialog(),
              ),
              title: S.current.add_todo,
              badge: const Icon(Icons.add),
              hasArrowRight: false,
              isCentered: true,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 10,
          child: TextButton(
            onPressed: () => ref.read(showDeleteProvider.notifier).state =
                !ref.read(showDeleteProvider),
            child: FirebaseTestText.extraBoldBody(
              showDeleteState ? S.current.cancel : S.current.delete,
              context: context,
            ),
          ),
        ),
      ],
    );
  }
}
