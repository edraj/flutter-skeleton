import 'package:flutter/material.dart';
import 'package:dmart_android_flutter/presentations/widgets/field_error_container.dart';
import 'package:dmart_android_flutter/utils/constants/colors.dart';
import 'package:dmart_android_flutter/utils/helpers/advance_text_editing_controller.dart';

class EditField extends StatefulWidget {
  AdvanceTextEditingController controller;
  String palceholder;
  bool? obscureText = false;
  Widget? prefix;
  int? maxLength;
  String? Function(String)? validationFunction;

  EditField({
    super.key,
    required this.controller,
    required this.palceholder,
    this.obscureText,
    this.prefix,
    this.maxLength,
    this.validationFunction,
  });

  @override
  State<EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  late InputDecoration inputDecoration;

  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
  );

  final TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontFamily: 'KanunAR',
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
  );

  InputDecoration generateInputDecoration(bool isOk, [String? message]) {
    Widget? suffixIcon = widget.obscureText == null
        ? null
        : GestureDetector(
            onTap: () {
              setState(() {
                toggleObscureText();
              });
            },
            child: Icon(
              (widget.obscureText ?? false)
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: secondaryColor,
            ),
          );

    TextStyle textStyle = TextStyle(
      color: secondaryColor ?? Colors.grey,
      fontFamily: 'KanunAR',
      fontWeight: FontWeight.w500,
      fontSize: 15.0,
    );

    return isOk
        ? InputDecoration(
            border: outlineInputBorder,
            hintText: widget.palceholder,
            filled: true,
            isDense: true,
            hintStyle: textStyle,
            fillColor: inputBackgroundColor,
            prefixIcon: widget.prefix,
            suffixIcon: suffixIcon,
            counterText: "",
          )
        : InputDecoration(
            border: outlineInputBorder,
            hintText: widget.palceholder,
            filled: true,
            isDense: true,
            hintStyle: textStyle,
            fillColor: inputBackgroundColor,
            suffixIcon: suffixIcon,
            prefixIcon: widget.prefix,
            counterText: "",
            error: FieldErrorContainer(
              message: message ?? "",
            ),
          );
  }

  void checkValidation(String? value) {
    if (value == null) {
      setState(() {
        inputDecoration = generateInputDecoration(true);
      });
    } else {
      setState(() {
        inputDecoration = generateInputDecoration(false, value);
      });
    }
  }

  void toggleObscureText() {
    setState(() {
      widget.obscureText = !(widget.obscureText ?? false);
      inputDecoration = generateInputDecoration(
        widget.controller.isValidated,
        widget.controller.errorMessage,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    inputDecoration = generateInputDecoration(true);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      decoration: inputDecoration,
      style: textStyle,
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: widget.obscureText ?? false,
      validator: (value) {
        if (widget.validationFunction != null) {
          String? errorMessage = widget.validationFunction!(value!);
          checkValidation(errorMessage);
          widget.controller.isValidated = errorMessage == null;
          widget.controller.errorMessage = errorMessage;
        }
        return null;
      },
    );
  }
}
