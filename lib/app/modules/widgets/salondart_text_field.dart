import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'package:reactive_forms/reactive_forms.dart';

import 'package:simple_animations/simple_animations.dart';

class ReactiveCustomTextField<T> extends ReactiveFormField<T, String> {
  ReactiveCustomTextField({
    super.key,
    String? labelText,
    super.formControlName,
    super.formControl,
    Map<String, String> Function(FormControl<T>)? validationMessages,
    TextEditingController? controller,
    int? minLines,
    int? maxLines,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    InputDecoration decoration = const InputDecoration(
      border: InputBorder.none,
    ),
    bool isKeyboardActionsEnabled = false,
    Function(String)? onSubmitted,
    Widget? suffix,
    bool isErrorShowInSuffix = false,
    String? textValidInSuffix,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    EdgeInsets? margin,
    double? height,
  })  : _textController = controller,
        super(
          builder: (ReactiveFormFieldState<T, String> field) {
            final state = field as _ReactiveDocPrescTextFieldState<T>;
            final hasErrors =
                field.errorText != null && field.errorText!.isNotEmpty;
            state._setFocusNode(focusNode);
            return DocPrescTextField(
              key: key,
              enabled: enabled,
              minLines: minLines,
              maxLines: maxLines,
              textCapitalization: textCapitalization,
              isKeyboardActionsEnabled: keyboardType == TextInputType.phone ||
                  keyboardType == TextInputType.number ||
                  isKeyboardActionsEnabled,
              controller: state._textController,
              focusNode: state.focusNode,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              labelText: labelText,
              decoration: decoration,
              hasErrors: hasErrors,
              onSubmitted: onSubmitted,
              onChanged: field.didChange,
              errorText: field.errorText ?? '',
              suffix: suffix,
              isErrorShowInSuffix: isErrorShowInSuffix,
              textValidInSuffix: textValidInSuffix,
              textStyle: textStyle,
              labelStyle: labelStyle,
              margin: margin,
              height: height,
            );
          },
        );

  late final TextEditingController? _textController;

  @override
  ReactiveFormFieldState<T, String> createState() =>
      _ReactiveDocPrescTextFieldState<T>();
}

class _ReactiveDocPrescTextFieldState<T>
    extends ReactiveFormFieldState<T, String> {
  late TextEditingController _textController;
  late FocusController _focusController;
  FocusNode? _focusNode;
  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();
    _initializeTextController();
  }

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );

    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor<T, String> selectValueAccessor() {
    if (control is FormControl<int>) {
      return IntValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<double>) {
      return DoubleValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<DateTime>) {
      return DateTimeValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<TimeOfDay>) {
      return TimeOfDayValueAccessor() as ControlValueAccessor<T, String>;
    }

    return super.selectValueAccessor();
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }

  void _initializeTextController() {
    final initialValue = value;
    final currentWidget = widget as ReactiveCustomTextField<T>;
    _textController = (currentWidget._textController != null)
        ? currentWidget._textController!
        : TextEditingController();

    if (initialValue == null) {
      _textController.text = '';
      return;
    }
    _textController.text = initialValue;
  }
}

class DocPrescTextField extends StatefulWidget {
  const DocPrescTextField({
    Key? key,
    this.labelText,
    this.errorText = '',
    this.enabled = false,
    this.hasErrors = false,
    this.maxLines,
    this.minLines,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.value,
    this.inputFormatters,
    this.isKeyboardActionsEnabled = false,
    this.decoration = const InputDecoration(
      border: InputBorder.none,
    ),
    this.suffix,
    this.isErrorShowInSuffix = false,
    this.textValidInSuffix,
    this.textStyle,
    this.labelStyle,
    this.margin,
    this.height,
  }) : super(key: key);

  final String? labelText;
  final String errorText;

  final bool hasErrors;
  final bool enabled;

  final int? maxLines;
  final int? minLines;

  final String? value;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final InputDecoration decoration;
  final List<TextInputFormatter>? inputFormatters;
  final bool isKeyboardActionsEnabled;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  final Widget? suffix;
  final bool isErrorShowInSuffix;

  final String? textValidInSuffix;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final EdgeInsets? margin;
  final double? height;

  @override
  State<DocPrescTextField> createState() => _DocPrescTextFieldState();
}

class _DocPrescTextFieldState extends State<DocPrescTextField>
    with AnimationMixin {
  late Animation<double> spreadRadiusAnim;
  late FocusNode _focusNode;
  late TextEditingController _controller;

  bool isFocused = false;

  final double _spreadRadiusBegin = 0;
  final double _spreadRadiusEnd = 3;

  static const _errorBorderColor = Colors.white;
  static const _unfocusedBorderColor = Colors.black12;
  static const _focusedBorderColor = Colors.white;

  void _onFocusChanged() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });

    if (isFocused) {
      controller.animateTo(_spreadRadiusEnd, curve: Curves.easeInOut);
      // controller.forward();
    } else {
      controller.animateTo(_spreadRadiusBegin, curve: Curves.easeInOut);
    }
  }

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    controller.duration = const Duration(milliseconds: 250);
    spreadRadiusAnim = Tween<double>(
      begin: _spreadRadiusBegin,
      end: _spreadRadiusEnd,
    ).animate(controller);

    _focusNode.addListener(_onFocusChanged);

    if (widget.controller == null) {
      _controller = TextEditingController();
      _controller.text = widget.value ?? '';
    } else {
      _controller = widget.controller!;
    }

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  Color _borderColor() {
    final hasErrors = widget.hasErrors;

    if (hasErrors) {
      return _errorBorderColor;
    }

    if (isFocused) {
      return _focusedBorderColor;
    }
    return _unfocusedBorderColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: !widget.enabled
              ? null
              : () => FocusScope.of(context).requestFocus(_focusNode),
          child: Container(
            height: widget.height ?? 56,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            margin: widget.margin ??
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: _borderColor(), width: 2),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: spreadRadiusAnim.value,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.labelText != null) ...[
                  Text(
                    widget.labelText!,
                    style: widget.labelStyle ??
                        TextStyle(
                          fontSize: 30.sp,
                        ),
                  ),
                ],
                KeyboardActions(
                  disableScroll: true,
                  enable: widget.isKeyboardActionsEnabled,
                  config: KeyboardActionsConfig(
                    keyboardBarColor: Colors.white,
                    defaultDoneWidget: const Text(
                      'Done',
                    ),
                    actions: [
                      KeyboardActionsItem(
                        focusNode: _focusNode,
                        displayArrows: false,
                        onTapAction: () => widget.onSubmitted?.call(
                          _controller.text,
                        ),
                      ),
                    ],
                  ),
                  child: TextField(
                    key: widget.key,
                    enabled: widget.enabled,
                    onSubmitted: widget.onSubmitted,
                    controller: widget.controller,
                    textCapitalization: widget.textCapitalization,
                    focusNode: _focusNode,
                    onChanged: (val) {
                      widget.onChanged!(val);
                    },
                    style: widget.textStyle ?? TextStyle(fontSize: 50.sp),
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    inputFormatters: widget.inputFormatters,
                    minLines: widget.minLines,
                    maxLines: widget.maxLines,
                    decoration: widget.decoration.copyWith(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      suffix: widget.suffix,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.hasErrors && widget.isErrorShowInSuffix == false)
          Padding(
            padding: const EdgeInsets.only(
              left: 50,
              right: 16,
              top: 0,
            ),
            child: Text(
              widget.errorText,
              style: widget.decoration.errorStyle ??
                  TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 12,
                  ),
            ),
          ),
      ],
    );
  }
}
