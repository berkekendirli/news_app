import 'package:flutter/material.dart';
import 'package:news_app/screens/welcome_screen.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color.fromARGB(255, 169, 184, 194),
          selectionHandleColor: Color.fromARGB(255, 70, 71, 77),
          cursorColor: Color.fromARGB(255, 70, 71, 77),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}
