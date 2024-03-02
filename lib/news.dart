import 'package:flutter/material.dart';
import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/screens/register_screen.dart';
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
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 206, 222, 255),
              ],
            ),
          ),
          child: const WelcomePage(),
        ),
      ),
    );
  }
}
