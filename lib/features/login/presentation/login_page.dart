import 'package:firebase_test/common/presentation/widgets/action_button.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_text.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_text_field.dart';
import 'package:firebase_test/features/auth/domain/entities/login_type.dart';
import 'package:firebase_test/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:firebase_test/features/auth/forms/auth_form.dart';
import 'package:firebase_test/generated/l10n.dart';
import 'package:firebase_test/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _loginFormKey = GlobalKey<FormBuilderState>();
  final _passwordTextController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _loginFormKey,
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing16),
          children: [
            const SizedBox(
              height: AppSizes.borderRadius40,
            ),
            Align(
              alignment: Alignment.center,
              child: FirebaseTestText.extraBoldLarge(
                S.current.login,
                context: context,
              ),
            ),
            const SizedBox(
              height: AppSizes.borderRadius40,
            ),
            FirebaseTestTextField.email(
              fieldName: AuthForm.emailKey,
              title: S.current.email,
              text: S.current.your_email,
              isRequired: true,
              isRequiredValidatorErrorText: S.current.enter_your_email,
              textInputAction: TextInputAction.next,
              borderColor: CustomColors.grey500,
            ),
            const SizedBox(height: AppSizes.spacing12),
            FirebaseTestTextField.password(
              fieldName: AuthForm.passwordKey,
              textEditingController: _passwordTextController,
              title: S.current.password,
              text: S.current.your_password,
              isRequired: true,
              isRequiredValidatorErrorText: S.current.enter_your_password,
              borderColor: CustomColors.grey500,
            ),
            const SizedBox(height: AppSizes.spacing24),
            ActionButton.primary(
              isLoading: false,
              onTap: () => loginOnPressed(loginType: LoginType.firebase),
              title: S.current.login_with_firebase,
            ),
            const SizedBox(
              height: AppSizes.borderRadius16,
            ),
            ActionButton.primary(
              isLoading: false,
              onTap: () => loginOnPressed(loginType: LoginType.supabase),
              title: S.current.login_with_supabase,
            ),
          ],
        ),
      ),
    );
  }

  void loginOnPressed({required LoginType loginType}) {
    _loginFormKey.currentState?.saveAndValidate();
    if (_loginFormKey.currentState?.isValid == true) {
      ref.read(authNotifierProvider.notifier).submitLoginForm(
            formMap: _loginFormKey.currentState!.value,
            loginType: loginType,
          );
    }
  }
}
