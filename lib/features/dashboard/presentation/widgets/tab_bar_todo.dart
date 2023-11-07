import 'package:firebase_test/common/presentation/widgets/firebase_test_text.dart';
import 'package:firebase_test/features/dashboard/domain/providers.dart';
import 'package:firebase_test/generated/l10n.dart';
import 'package:firebase_test/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabBarTodo extends ConsumerStatefulWidget {
  const TabBarTodo({super.key});

  @override
  ConsumerState createState() => _TabBarTodoState();
}

class _TabBarTodoState extends ConsumerState<TabBarTodo>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: ref.read(selectedTabProvider).index,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTabState = ref.watch(selectedTabProvider);
    return TabBar(
      controller: _tabController,
      indicator: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ), // Creates border
        color: CustomColors.primaryDefault,
      ),
      onTap: (index) => ref
          .read(selectedTabProvider.notifier)
          .update((state) => state = TodoTabs.values[index]),
      splashBorderRadius: const BorderRadius.all(
        Radius.circular(50),
      ),
      tabs: [
        Tab(
          child: FirebaseTestText.extraBoldBody(
            S.current.all,
            color: selectedTabState == TodoTabs.all
                ? Colors.white
                : CustomColors.primaryDefault,
            context: context,
          ),
        ),
        Tab(
          child: FirebaseTestText.extraBoldBody(S.current.completed,
              color: selectedTabState == TodoTabs.completed
                  ? Colors.white
                  : CustomColors.primaryDefault,
              context: context),
        ),
        Tab(
          child: FirebaseTestText.extraBoldBody(S.current.active,
              color: selectedTabState == TodoTabs.active
                  ? Colors.white
                  : CustomColors.primaryDefault,
              context: context),
        ),
      ],
    );
  }
}

enum TodoTabs {
  all(0),
  completed(1),
  active(2);

  final int selectionIndex;

  const TodoTabs(this.selectionIndex);
}
