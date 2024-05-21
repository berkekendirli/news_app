import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/methods/blog_tile.dart';
import 'package:share_plus/share_plus.dart';

class PopUpItems extends StatelessWidget {
  final String newsUrl;
  final BuildContext context;
  final BlogTile blogTile;
  const PopUpItems(
      {super.key,
      required this.newsUrl,
      required this.context,
      required this.blogTile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                blogTile.addToBookmarks(
                    context, user.uid); // Call BlogTile's method
              } else {
                // Show a message prompting the user to sign in
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please sign in to bookmark news'),
                  ),
                );
              }
            },
            child: Container(
              height: 50,
              color: Colors.white,
              child: const Icon(
                Icons.bookmark,
                color: Color.fromARGB(255, 82, 82, 82),
              ),
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
