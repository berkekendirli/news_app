import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  const ArticleView({Key? key, required this.blogUrl}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  // Функция для добавления новости в закладки
  void addToBookmarks(String newsId) {
    // Вставьте здесь вашу логику для добавления в закладки
    // Пример: добавление в коллекцию Firebase
    FirebaseFirestore.instance.collection('bookmarks').add({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'newsId': newsId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Beykoz',
              style: GoogleFonts.ptSerif(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              'News',
              style: GoogleFonts.ptSerif(
                color: const Color.fromARGB(255, 255, 58, 68),
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          child: WebView(
            initialUrl: widget.blogUrl,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.blogUrl));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Link copied to clipboard')),
                );
              },
              icon: const Icon(Icons.link),
            ),
            IconButton(
              onPressed: () async {
                var url = Uri.parse(widget.blogUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not launch URL'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.travel_explore),
            ),
            IconButton(
              onPressed: () {
                Share.share(widget.blogUrl);
              },
              icon: const Icon(Icons.share),
            ),
            IconButton(
              onPressed: () {
                addToBookmarks(
                    widget.blogUrl); // Используем URL в качестве идентификатора
              },
              icon: const Icon(Icons.bookmark),
            ),
          ],
        ),
      ),
    );
  }
}
