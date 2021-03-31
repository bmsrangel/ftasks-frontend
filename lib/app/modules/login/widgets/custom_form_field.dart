import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomFormField extends TextFormField {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) validationFunction;
  final String labelText;
  final bool obscureText;
  final FocusNode focusNode;
  final IconData suffixIcon;
  final Function onSuffixIconPressed;
  final Color cursorColor;

  CustomFormField({
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.validationFunction,
    this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.cursorColor,
  }) : super(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          validator: validationFunction,
          obscureText: obscureText,
          cursorColor: cursorColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            suffixIcon: IconButton(
              icon: Icon(suffixIcon),
              onPressed: onSuffixIconPressed,
            ),
          ),
        );
}
