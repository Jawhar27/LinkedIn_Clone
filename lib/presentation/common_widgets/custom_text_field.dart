import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.suffixWidget,
    this.hintStyle,
    this.inputTextStyle,
    required this.hintText,
    this.labelText,
    this.contentPadding,
    this.isObscureText = false,
    this.suffixIconWidget,
    this.prefixIconWidget,
    this.textFormFieldBorderRadius = 5.0,
    this.isBorderNeeded = true,
  });

  final Widget? suffixWidget;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final String? labelText;
  final EdgeInsetsGeometry? contentPadding;
  final bool isObscureText;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
  final double textFormFieldBorderRadius;
  final bool isBorderNeeded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: labelText != null,
          child: Text(
            labelText ?? '',
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
        Visibility(
          visible: labelText != null,
          child: const SizedBox(
            height: 5.0,
          ),
        ),
        TextFormField(
          style: inputTextStyle,
          controller: controller,
          onChanged: onChanged,
          obscureText: isObscureText,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: contentPadding,
            border: isBorderNeeded
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(
                      textFormFieldBorderRadius,
                    )),
                  )
                : const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                5,
              ),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                5.0,
              ),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            prefixIcon: prefixIconWidget,
            hintText: hintText,
            hintStyle: hintStyle,
            suffix: suffixWidget,
            suffixIcon: suffixIconWidget,
          ),
        ),
      ],
    );
  }
}
