import 'package:flutter/material.dart';
import 'package:news_app/methods/gradient_design.dart';
import 'package:news_app/methods/news_square.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: gradientBackground(),
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NewsSquareTile(tileHeight: 350),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NewsSquareTile(tileHeight: 170),
                      SizedBox(
                        width: 10,
                      ),
                      NewsSquareTile(tileHeight: 170),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NewsSquareTile(tileHeight: 170),
                      SizedBox(
                        width: 10,
                      ),
                      NewsSquareTile(tileHeight: 170),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NewsSquareTile(tileHeight: 170),
                      SizedBox(
                        width: 10,
                      ),
                      NewsSquareTile(tileHeight: 170),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NewsSquareTile(tileHeight: 170),
                      SizedBox(
                        width: 10,
                      ),
                      NewsSquareTile(tileHeight: 170),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NewsSquareTile(tileHeight: 170),
                      SizedBox(
                        width: 10,
                      ),
                      NewsSquareTile(tileHeight: 170),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NewsSquareTile(tileHeight: 170),
                      SizedBox(
                        width: 10,
                      ),
                      NewsSquareTile(tileHeight: 170),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
