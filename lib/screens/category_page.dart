import 'package:flutter/material.dart';
import 'package:news_app/methods/blog_tile.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_data.dart';

class CategoryNews extends StatefulWidget {
  final String name;

  const CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  void didUpdateWidget(CategoryNews oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the category name has changed
    if (oldWidget.name != widget.name) {
      // Fetch news for the new category name
      getNews();
    }
  }

  Future<void> getNews() async {
    setState(() {
      _loading = true; // Show loading indicator
    });
    News newsclass = News();
    await newsclass.getNews(widget.name.toLowerCase());
    setState(() {
      articles = newsclass.news;
      _loading = false; // Hide loading indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 255, 58, 68),
            ),
          ),
        )
        : ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return BlogTile(
              imageUrl: articles[index].urlToImage!,
              sourceName: articles[index].source!,
              title: articles[index].title!,
              url: articles[index].url!,
            );
          },
        );
  }
}
