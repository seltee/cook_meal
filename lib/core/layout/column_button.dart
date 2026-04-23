import 'package:flutter/material.dart';

class ColumnButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const ColumnButton({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
          ),
          child: child,
        ),
      ),
    );
  }
}
