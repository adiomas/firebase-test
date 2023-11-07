import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:firebase_test/common/presentation/widgets/action_button.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_text_field.dart';
import 'package:firebase_test/features/dashboard/domain/notifiers/todo_notifier.dart';
import 'package:firebase_test/features/dashboard/forms/todo_form.dart';
import 'package:firebase_test/generated/l10n.dart';
import 'package:firebase_test/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoDialog extends ConsumerWidget {
  const TodoDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoFormKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: todoFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FirebaseTestTextField.normal(
            fieldName: TodoForm.titleKey,
            title: S.current.title,
            isRequired: true,
            text: S.current.write_here,
            isRequiredValidatorErrorText: S.current.required_field,
            borderColor: CustomColors.grey500,
          ),
          const SizedBox(
            height: AppSizes.borderRadius8,
          ),
          FirebaseTestTextField.normal(
            fieldName: TodoForm.descriptionKey,
            title: S.current.description,

            // text: S.current.write_here,
            multiline: true,
            isRequiredValidatorErrorText: S.current.required_field,
            borderColor: CustomColors.grey500,
          ),
          const SizedBox(
            height: AppSizes.borderRadius20,
          ),
          Row(
            children: [
              Expanded(flex: 2, child: Container()),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 3,
                child: ActionButton.primary(
                  onTap: () {
                    todoFormKey.currentState?.saveAndValidate();
                    if (todoFormKey.currentState?.validate() == true) {
                      ref
                          .read(todoNotifierProvider.notifier)
                          .addTodo(formMap: todoFormKey.currentState!.value);
                      Navigator.of(context).pop();
                    }
                  },
                  title: S.current.add,
                  isCentered: true,
                  hasArrowRight: false,
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
