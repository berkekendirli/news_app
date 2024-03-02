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
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 170, 101, 101),
                Color.fromARGB(255, 104, 7, 7),
              ],
            ),
          ),
          child: const WelcomePage(),
        ),
      ),
    );
  }
}
