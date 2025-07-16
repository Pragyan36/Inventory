import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.label,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff1B2632),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      icon: Image.asset(
        imagePath,
        width: 15,
        height: 15,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
