import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:firebase_test/common/presentation/image_assets.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_button.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_text.dart';
import 'package:firebase_test/common/utils/build_context_extensions.dart';
import 'package:firebase_test/generated/l10n.dart';
import 'package:firebase_test/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';

class FirebaseTestTextField extends StatefulWidget {
  final String fieldName;
  final String title;
  final String? text;
  final bool isPassword;
  final TextEditingController? textEditingController;
  final FormFieldValidator<String>? validator;
  final void Function(String?)? onChanged;
  final bool isRequired;
  final TextStyle? style;
  final TextInputType? textInputType;
  final List<TextInputFormatter> inputFormatters;
  final AutovalidateMode? autoValidateMode;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final String? initialValue;
  final bool multiline;
  final int? maxLength;
  final bool autofocus;
  final FocusNode? focusNode;
  final Color? borderColor;

  const FirebaseTestTextField._({
    required this.fieldName,
    required this.title,
    this.text,
    this.validator,
    this.style,
    this.isPassword = false,
    required this.onChanged,
    required this.isRequired,
    this.textEditingController,
    this.textInputType,
    this.inputFormatters = const [],
    this.autoValidateMode,
    this.textCapitalization,
    this.textInputAction,
    required this.readOnly,
    this.initialValue,
    required this.multiline,
    this.maxLength,
    required this.autofocus,
    this.focusNode,
    this.borderColor,
  });

  factory FirebaseTestTextField.password({
    required String fieldName,
    required String title,
    required String text,
    TextEditingController? textEditingController,
    FormFieldValidator<String>? validator,
    void Function(String?)? onChanged,
    String? initialValue,
    bool isRequired = false,
    AutovalidateMode? autoValidateMode,
    String? isRequiredValidatorErrorText,
    TextInputAction? textInputAction,
    bool readOnly = false,
    bool multiline = false,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? borderColor,
  }) =>
      FirebaseTestTextField._(
        fieldName: fieldName,
        title: title,
        text: text,
        textEditingController: textEditingController,
        isPassword: true,
        validator: FormBuilderValidators.compose([
          if (isRequired)
            FormBuilderValidators.required(
              errorText:
                  isRequiredValidatorErrorText ?? S.current.required_field,
            ),
          if (validator != null) validator,
        ]),
        onChanged: onChanged,
        isRequired: isRequired,
        textInputAction: textInputAction,
        autoValidateMode: autoValidateMode,
        readOnly: readOnly,
        initialValue: initialValue,
        multiline: multiline,
        autofocus: autofocus,
        focusNode: focusNode,
        borderColor: borderColor,
      );

  factory FirebaseTestTextField.normal({
    required String fieldName,
    required String title,
    String? text,
    FormFieldValidator<String>? validator,
    void Function(String?)? onChanged,
    TextInputType? textInputType,
    TextEditingController? textEditingController,
    String? initialValue,
    TextStyle? style,
    bool isRequired = false,
    List<TextInputFormatter>? inputFormatters,
    AutovalidateMode? autoValidateMode,
    String? isRequiredValidatorErrorText,
    TextInputAction? textInputAction,
    bool readOnly = false,
    bool multiline = false,
    int? maxLength,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? borderColor,
  }) =>
      FirebaseTestTextField._(
        fieldName: fieldName,
        title: title,
        text: text,
        validator: FormBuilderValidators.compose([
          if (isRequired)
            FormBuilderValidators.required(
              errorText:
                  isRequiredValidatorErrorText ?? S.current.required_field,
            ),
          if (validator != null) validator,
        ]),
        textInputType: textInputType,
        onChanged: onChanged,
        textEditingController: textEditingController,
        style: style,
        isRequired: isRequired,
        inputFormatters: inputFormatters ?? [],
        autoValidateMode: autoValidateMode,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: textInputAction,
        readOnly: readOnly,
        initialValue: initialValue,
        multiline: multiline,
        maxLength: maxLength,
        autofocus: autofocus,
        focusNode: focusNode,
        borderColor: borderColor,
      );

  factory FirebaseTestTextField.email({
    required String fieldName,
    required String title,
    required String text,
    FormFieldValidator<String>? validator,
    void Function(String?)? onChanged,
    String? initialValue,
    bool isRequired = false,
    AutovalidateMode? autoValidateMode,
    String? isRequiredValidatorErrorText,
    TextInputAction? textInputAction,
    bool readOnly = false,
    bool multiline = false,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? borderColor,
  }) =>
      FirebaseTestTextField._(
        fieldName: fieldName,
        title: title,
        text: text,
        validator: FormBuilderValidators.compose([
          if (isRequired)
            FormBuilderValidators.required(
              errorText:
                  isRequiredValidatorErrorText ?? S.current.required_field,
            ),
          validator ??
              FormBuilderValidators.email(
                errorText: S.current.not_valid_email,
              ),
        ]),
        onChanged: onChanged,
        isRequired: isRequired,
        textInputType: TextInputType.emailAddress,
        autoValidateMode: autoValidateMode,
        textInputAction: textInputAction,
        readOnly: readOnly,
        initialValue: initialValue,
        multiline: multiline,
        autofocus: autofocus,
        focusNode: focusNode,
        borderColor: borderColor,
      );

  factory FirebaseTestTextField.number({
    required String fieldName,
    required String title,
    String? text,
    void Function(String?)? onChanged,
    TextEditingController? textEditingController,
    String? initialValue,
    TextStyle? style,
    bool isRequired = false,
    AutovalidateMode? autoValidateMode,
    String? isRequiredValidatorErrorText,
    TextInputAction? textInputAction,
    bool readOnly = false,
    bool decimal = false,
    int min = 1,
    int max = 10000,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? borderColor,
  }) =>
      FirebaseTestTextField._(
        fieldName: fieldName,
        title: title,
        text: text,
        validator: FormBuilderValidators.compose([
          if (isRequired)
            FormBuilderValidators.required(
              errorText:
                  isRequiredValidatorErrorText ?? S.current.required_field,
            ),
          FormBuilderValidators.numeric(),
          FormBuilderValidators.min(min),
          FormBuilderValidators.max(max),
          if (!decimal) FormBuilderValidators.integer(),
        ]),
        textInputType: TextInputType.numberWithOptions(
          signed: min < 0 || decimal,
          decimal: decimal,
        ),
        onChanged: onChanged,
        textEditingController: textEditingController,
        style: style,
        isRequired: isRequired,
        autoValidateMode: autoValidateMode,
        textInputAction: textInputAction,
        readOnly: readOnly,
        initialValue: initialValue,
        multiline: false,
        autofocus: autofocus,
        focusNode: focusNode,
        borderColor: borderColor,
      );

  @override
  State<FirebaseTestTextField> createState() => _FirebaseTestTextFieldState();
}

class _FirebaseTestTextFieldState extends State<FirebaseTestTextField> {
  late bool isHidden;
  TextEditingController? _textEditingController;
  FocusNode? _focusNode;

  @override
  void initState() {
    isHidden = widget.isPassword;
    _textEditingController = widget.textEditingController ??
        TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.textEditingController == null) _textEditingController?.dispose();
    if (widget.focusNode == null) _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.readOnly,
      child: FormBuilderField(
        name: widget.fieldName,
        focusNode: _focusNode,
        validator: widget.validator,
        initialValue: widget.initialValue,
        onChanged: (String? value) => widget.onChanged?.call(value),
        autovalidateMode:
            widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
        builder: (field) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirebaseTestText.semiBoldBody(
              widget.title,
              context: context,
              color: CustomColors.grey800,
            ),
            const SizedBox(height: AppSizes.spacing4),
            SizedBox(
              height: widget.multiline ? null : 46,
              child: TextField(
                textCapitalization:
                    widget.textCapitalization ?? TextCapitalization.none,
                controller: _textEditingController,
                focusNode: _focusNode,
                onChanged: (value) => field.didChange(value),
                inputFormatters: [
                  RemoveEmojiInputFormatter(),
                  ...widget.inputFormatters,
                ],
                style: widget.style ??
                    context.appTextStyles.extraBoldBody?.copyWith(
                      color: !widget.readOnly
                          ? CustomColors.baseBlack
                          : CustomColors.grey500,
                    ),
                maxLines: widget.multiline ? 6 : 1,
                maxLength: widget.maxLength,
                textInputAction: widget.textInputAction,
                obscureText: isHidden,
                enableSuggestions: !isHidden,
                autocorrect: !isHidden,
                keyboardType: widget.textInputType,
                autofocus: widget.autofocus,
                decoration: InputDecoration(
                  hintText: widget.text,
                  hintStyle: context.appTextStyles.extraBoldBody?.copyWith(
                    color: CustomColors.grey500,
                  ),
                  counterStyle: context.appTextStyles.semiBoldTiny
                      ?.copyWith(color: CustomColors.grey800),
                  suffixIcon: widget.isPassword
                      ? FirebaseTestButton(
                          onTap: _changeTextVisibility,
                          child: SvgPicture.asset(
                            isHidden
                                ? ImageAssets.eyeIcon
                                : ImageAssets.eyeCrossedIcon,
                          ),
                        )
                      : null,
                  enabledBorder: field.hasError
                      ? const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: CustomColors.alertCritical),
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.borderRadius8),
                          ),
                        )
                      : OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.borderColor ?? Colors.transparent,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppSizes.borderRadius8),
                          ),
                        ),
                  focusedBorder: field.hasError
                      ? const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: CustomColors.alertCritical),
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.borderRadius8),
                          ),
                        )
                      : OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.borderColor ?? Colors.transparent,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppSizes.borderRadius8),
                          ),
                        ),
                  contentPadding: EdgeInsets.only(
                    left: AppSizes.spacing16,
                    right: widget.multiline ? AppSizes.spacing16 : 0,
                    top: widget.multiline ? AppSizes.spacing16 : 0,
                  ),
                  fillColor: CustomColors.baseWhite,
                  filled: true,
                ),
              ),
            ),
            if (field.hasError) ...[
              const SizedBox(height: AppSizes.spacing4),
              FirebaseTestText.semiBoldSmall(
                field.errorText!,
                context: context,
                color: CustomColors.alertCritical,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _changeTextVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
