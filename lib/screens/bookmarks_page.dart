import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/methods/blog_tile.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
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
              'Book',
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
              'marks',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: FutureBuilder(
          future: delayedFuture(),
          builder: (context, AsyncSnapshot<void> delaySnapshot) {
            if (delaySnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 255, 58, 68),
                ),
              );
            } else {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('bookmarks')
                    .where('userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 255, 58, 68),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No bookmarks found',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    );
                  } else {
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return BlogTile(
                          url: document['newsId'],
                          imageUrl: document['imageFire'],
                          sourceName: document['sourceFire'],
                          title: document['titleFire'],
                        );
                      }).toList(),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}

Future<void> delayedFuture() async {
  await Future.delayed(
    const Duration(milliseconds: 500),
  ); // Delay duration
}
