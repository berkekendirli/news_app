import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/methods/popup_menu_items.dart'; // Import for PopUpItems
import 'package:news_app/models/bookmark_model.dart'; // Import for BookmarkedNews
import 'package:news_app/screens/article_view.dart';
import 'package:popover/popover.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, sourceName, url;

  // Move the function definition before the constructor
  void addToBookmarks(BuildContext context, String userId) async {
    final bookmarkedNews = BookmarkedNews(
      title: title,
      url: url,
      sourceName: sourceName,
      userId: userId,
    );

    // Get a reference to the Firestore collection
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('bookmarks');

    // Add the bookmarked news data to the collection
    await collectionRef.add(bookmarkedNews.toMap());

    // Show a confirmation snackbar or toast (optional)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('News bookmarked successfully!'),
      ),
    );
  }

  const BlogTile({
    super.key,
    required this.sourceName,
    required this.imageUrl,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showPopover(
        context: context,
        bodyBuilder: (context) => PopUpItems(
          context: context,
          newsUrl: url,
          blogTile: this,
        ),
        width: 225,
        backgroundColor: Colors.white,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(blogUrl: url),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 128,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.black45,
                height: 128,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 128,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.ptSerif(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        sourceName,
                        style: GoogleFonts.nunito(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
