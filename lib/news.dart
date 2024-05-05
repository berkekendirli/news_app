import 'package:flutter/material.dart';
import 'package:news_app/screens/auth_page.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color.fromARGB(255, 240, 241, 250),
          selectionHandleColor: Color.fromARGB(255, 255, 58, 68),
          cursorColor: Color.fromARGB(255, 70, 71, 77),
        ),
      ),
      home: const AuthPage(),
    );
  }
}
