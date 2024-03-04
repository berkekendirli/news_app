import 'package:flutter/material.dart';

BoxDecoration gradientBackground() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 151, 182, 243),
      ],
    ),
  );
}
