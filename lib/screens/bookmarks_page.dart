import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  late List<DocumentSnapshot> bookmarkedNews = [];

  @override
  void initState() {
    super.initState();
    fetchBookmarkedNews();
  }

  Future<void> fetchBookmarkedNews() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final snapshot = await FirebaseFirestore.instance
          .collection('bookmarks')
          .where('userId', isEqualTo: userId)
          .get();
      setState(() {
        bookmarkedNews = snapshot.docs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: bookmarkedNews.length,
        itemBuilder: (context, index) {
          final data = bookmarkedNews[index].data() as Map<String, dynamic>;
          return ListTile(
            title: Text(data['title']),
            subtitle: Text(data['sourceName']),
            onTap: () {
              // Navigate to the article view page or do something else
            },
          );
        },
      ),
    );
  }
}
