import 'package:blnk_task/util/app_colors.dart';
import 'package:flutter/material.dart';

import '../../util/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onDone;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  const CustomTextField(
      {super.key,
      this.controller,
      required this.labelText,
      this.hintText,
      this.onDone,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.onChanged,
      this.validator,
      this.focusNode});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      focusNode: widget.focusNode,
      style: AppTheme.activeProgress.copyWith(
          color: AppColors.appBarTitleColor), // Style for the actual input text
      decoration: InputDecoration(
        labelText: widget.labelText, // The "title" of the input field
        labelStyle: AppTheme.textFieldTitle, // Style for the label text

        // This makes the label always "float" on the border, even when empty
        // If you want it to be inside and then float on focus, use FloatingLabelBehavior.auto
        floatingLabelBehavior: FloatingLabelBehavior.always,

        hintText: widget.hintText, // Placeholder text inside the field
        // Style for the hint text

        // Define the border when the field is enabled but not focused
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(6.0), // Rounded corners for the border
          borderSide: const BorderSide(
            color: AppColors.textFieldBorderColor, // Grey border color
            width: 1.0,
          ),
        ),
        // Define the border when the field is focused
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(
            color: AppColors
                .textFieldBorderColor, // Use theme's primary color when focused
            width: 2.0, // Slightly thicker border when focused
          ),
        ),
        // Define the border when there's an error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(
            color: Colors.red, // Red border for errors
            width: 1.0,
          ),
        ),
        // Define the border when focused and there's an error
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        // This is crucial for the "cut-out" effect for the label background
        // The color behind the label will be Theme.of(context).canvasColor (usually white)
        // You can explicitly set a fillColor for the entire input area if needed,
        // but the label background is handled by the notch itself.
        fillColor: Colors.white, // Background color of the input field itself
        filled: true, // Must be true for fillColor to take effect

        // Adjust content padding inside the text field
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      onTapOutside: (event) {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
      },
      onEditingComplete: widget.onDone,
    );
  }
}
