// save_button.dart
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      color: const Color(0xFF22538D),
      onPressed: onPressed,
      child: const Text('Save'),
    );
  }
}
