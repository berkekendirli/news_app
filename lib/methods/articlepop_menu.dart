import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ArticlePopUp extends StatelessWidget {
  final String newsUrl;
  const ArticlePopUp({super.key, required this.newsUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: const Icon(
            Icons.bookmark,
            color: Color.fromARGB(255, 82, 82, 82),
          ),
        ),
        Divider(),
        GestureDetector(
          onTap: () {
            Share.share(newsUrl);
          },
          child: Container(
            color: Colors.white,
            child: const Icon(
              Icons.share,
              color: Color.fromARGB(255, 82, 82, 82),
            ),
          ),
        ),
      ],
    );
  }
}
