import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class PopUpItems extends StatelessWidget {
  final String newsUrl;
  const PopUpItems({super.key, required this.newsUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 50,
            color: Colors.white,
            child: const Icon(
              Icons.bookmark,
              color: Color.fromARGB(255, 82, 82, 82),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
          child: VerticalDivider(),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Share.share(newsUrl);
            },
            child: Container(
              height: 50,
              color: Colors.white,
              child: const Icon(
                Icons.share,
                color: Color.fromARGB(255, 82, 82, 82),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
