import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType; // Añade esta propiedad

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text, // Valor por defecto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge?.copyWith(fontSize: 20);
    final borderColor = theme.colorScheme.primary;

    return TextFormField(
      style: textStyle,
      maxLength: 30,
      cursorColor: theme.colorScheme.onSurface,
      controller: controller,
      keyboardType: keyboardType, // Usa el keyboardType aquí
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelText,
        labelStyle: textStyle,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 1.0, horizontal: 20),
        filled: true,
        fillColor: theme.colorScheme.surface,
        floatingLabelStyle:
            textStyle?.copyWith(color: theme.colorScheme.onSurface),
        hintStyle: textStyle?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      validator: validator,
    );
  }
}
