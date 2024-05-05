import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  const SquareTile({required this.imagePath, super.key});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.white),
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          imagePath,
          height: 80,
        ),
      ),
    );
  }
}
