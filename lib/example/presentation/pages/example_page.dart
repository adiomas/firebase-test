// ignore_for_file: always_use_package_imports, prefer-single-widget-per-file

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_state_notifier.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/presentation/build_context_extensions.dart';
import '../../../common/utils/q_logger.dart';
import '../../domain/notifiers/example_filters/example_filters_provider.dart';
import '../../domain/notifiers/example_notifier/example_state_notifier.dart';
import '../../domain/notifiers/example_simple_notifier/example_simple_state_notifier.dart';
import 'form_example_page.dart';
import 'pagination_example_page.dart';
import 'pagination_stream_example_page.dart';

class ExamplePage extends ConsumerWidget {
  static const routeName = '/';

  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exampleNotifierProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              switch (state) {
                BaseData(data: final sentence) => sentence,
                BaseLoading() => 'Loading',
                BaseInitial() => 'Initial',
                BaseError(failure: final failure) => failure.toString(),
              },
              style: context.appTextStyles.regular
                  ?.copyWith(color: context.appColors.secondary),
            ),

            TextButton(
              onPressed: ref
                  .read(exampleNotifierProvider.notifier)
                  .getSomeStringFullExample,
              child: Text(
                'Get string',
                style: context.appTextStyles.bold,
              ),
            ),
            TextButton(
              onPressed: ref
                  .read(exampleNotifierProvider.notifier)
                  .getSomeStringGlobalLoading,
              child: Text(
                'Global loading example',
                style: context.appTextStyles.bold,
              ),
            ),
            TextButton(
              onPressed: ref
                  .read(exampleNotifierProvider.notifier)
                  .getSomeStringsStreamed,
              child: Text(
                'Cache + Network loading example',
                style: context.appTextStyles.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => ref
                  .read(exampleFiltersProvider.notifier)
                  .update((_) => 'Random ${Random().nextInt(100)}'),
              child: Text(
                'Update filters (to trigger reload of data)',
                style: context.appTextStyles.bold,
              ),
            ),
            TextButton(
              onPressed: () => QLogger.showLogger(context),
              child: Text('Show log', style: context.appTextStyles.bold),
            ),
            //Navigation example
            TextButton(
              onPressed: () => ref.pushNamed(ExampleSimplePage.routeName),
              child: Text('Navigate', style: context.appTextStyles.bold),
            ),
            TextButton(
              onPressed: () => ref.pushNamed(FormExamplePage.routeName),
              child:
                  Text('Go to form example', style: context.appTextStyles.bold),
            ),
            TextButton(
              onPressed: () => ref.pushNamed(PaginationExamplePage.routeName),
              child:
                  Text('Go to pagination', style: context.appTextStyles.bold),
            ),
            TextButton(
              onPressed: () =>
                  ref.pushNamed(PaginationStreamExamplePage.routeName),
              child: Text(
                'Go to stream pagination',
                style: context.appTextStyles.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExampleSimplePage extends ConsumerStatefulWidget {
  static const routeName = '/simple-page';

  const ExampleSimplePage({super.key});

  @override
  ConsumerState<ExampleSimplePage> createState() => _ExampleSimplePageState();
}

class _ExampleSimplePageState extends ConsumerState<ExampleSimplePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exampleSimpleStateNotifierProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.when(
              initial: () => 'Initial',
              empty: () => 'Empty',
              fetching: () => 'Fetching',
              success: (string) => string,
              error: (failure) => failure.title,
            ),
            textAlign: TextAlign.center,
            style: context.appTextStyles.regular,
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(exampleSimpleStateNotifierProvider.notifier)
                  .getSomeStringSimpleExample();
              ref
                  .read(exampleSimpleStateNotifierProvider.notifier)
                  .getSomeStringSimpleExample();
            },
            child: Text(
              'Simple state example with debounce',
              style: context.appTextStyles.bold,
            ),
          ),
          TextButton(
            onPressed: ref
                .read(exampleSimpleStateNotifierProvider.notifier)
                .getSomeStringSimpleExampleGlobalLoading,
            child: Text(
              'Global loading example',
              style: context.appTextStyles.bold,
            ),
          ),
          ElevatedButton(
            onPressed: ref.pop,
            child: Text(
              'Go back!',
              style: context.appTextStyles.bold
                  ?.copyWith(color: context.appColors.background),
            ),
          ),
          TextButton(
            onPressed: () => ref.pushNamed(ExamplePage3.routeName),
            child: Text(
              'Navigate',
              style: context.appTextStyles.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ExamplePage3 extends ConsumerWidget {
  static const routeName = '${ExampleSimplePage.routeName}/page3';

  const ExamplePage3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate back to the second screen by popping the current route
              // off the stack.
              ref.pop();
            },
            child: Text(
              'Go back!',
              style: context.appTextStyles.bold
                  ?.copyWith(color: context.appColors.background),
            ),
          ),
        ],
      ),
    );
  }
}
