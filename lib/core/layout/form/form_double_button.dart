import 'package:flutter/material.dart';

class FormDoubleButton extends StatelessWidget {
  final VoidCallback onPressLeft;
  final String titleLeft;
  final VoidCallback onPressRight;
  final String titleRight;
  final bool disabled;

  const FormDoubleButton({
    super.key,
    required this.onPressLeft,
    required this.titleLeft,
    required this.onPressRight,
    required this.titleRight,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: disabled ? null : onPressLeft,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.white,
            ),
            child: Text(
              titleLeft,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: disabled ? null : onPressRight,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(
              titleRight,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
