import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/methods/articlepop_menu.dart';
import 'package:news_app/methods/popup_menu_items.dart';
import 'package:popover/popover.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  const ArticleView({super.key, required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
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
              style: GoogleFonts.playfairDisplay(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              'News',
              style: GoogleFonts.playfairDisplay(
                  color: const Color.fromARGB(255, 255, 58, 68),
                  fontWeight: FontWeight.w800,
                  fontSize: 22),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                showPopover(
                  height: 200,
                  width: 100,
                  context: context,
                  bodyBuilder: (context) =>
                      ArticlePopUp(newsUrl: widget.blogUrl),
                );
              },
              child: const Icon(Icons.more_vert),
            ),
          ),
        ],
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
    );
  }
}
