import 'package:flutter/material.dart';

class NewsSquareTile extends StatelessWidget {
  const NewsSquareTile({required this.tileHeight, super.key});
  final double tileHeight;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: tileHeight,
      width: tileHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.white),
        color: const Color.fromARGB(255, 163, 60, 60),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
