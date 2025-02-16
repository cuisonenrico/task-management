import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.onChangeText,
    this.hintText,
    this.errorText,
    this.initialValue,
    this.obscureText = false,
    this.icon,
    this.padding,
    this.margin,
    this.keyboardInput,
    this.maxLines = 1,
    this.controller,
    this.inputDecoration,
    this.fillColor,
    super.key,
  });

  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final bool obscureText;
  final IconData? icon;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextInputType? keyboardInput;
  final int? maxLines;
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;
  final Color? fillColor;

  final ValueChanged<String> onChangeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardInput ?? TextInputType.multiline,
        maxLines: maxLines,
        obscureText: obscureText,
        decoration: inputDecoration ??
            InputDecoration(
              errorText: errorText,
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              prefixIcon: icon != null
                  ? Icon(
                      icon,
                      color: Colors.grey,
                      size: 25,
                    )
                  : null,
              fillColor: fillColor ?? Colors.white,
              hintText: hintText ?? 'Input Here',
            ),
        onChanged: (text) => onChangeText(text),
      ),
    );
  }
}
