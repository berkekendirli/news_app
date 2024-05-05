import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/methods/blog_tile.dart';
import 'package:news_app/models/search_model.dart';
import 'package:news_app/services/search_data.dart';

class SearchPage extends StatefulWidget {
  final String searchQuery;
  const SearchPage({super.key, required this.searchQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchModel> searchResults = [];
  bool isLoading = true;
  @override
  void initState() {
    getSearchNews();
    super.initState();
  }

  Future<void> getSearchNews() async {
    Search searchclass = Search();
    await searchclass.getSearchNews(widget.searchQuery);
    searchResults = searchclass.search;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Search results for "${widget.searchQuery.toUpperCase()}"',
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                    
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 58, 68),
              ),
            )
          : searchResults.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: buildSearchResults(),
                )
              : Center(
                  child: Text('No search results found.',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),),
                ),
    );
  }

  Widget buildSearchResults() {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return BlogTile(
          sourceName: searchResults[index].source!,
          imageUrl: searchResults[index].urlToImage!,
          title: searchResults[index].title!,
          url: searchResults[index].url!,
        );
      },
    );
  }
}
