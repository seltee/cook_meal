import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final TextEditingController textController;
  final String label;
  final String hint;

  const FormInput({
    super.key,
    required this.textController,
    this.label = "",
    this.hint = "",
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is mandatory';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }
}
