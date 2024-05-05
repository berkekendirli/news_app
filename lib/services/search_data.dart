import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/search_model.dart';
import 'package:news_app/services/api_key.dart';

class Search {
  List<SearchModel> search = [];

  Future<void> getSearchNews(String query) async {
    String apiKey = newsApiKey;
    String url =
        "http://newsapi.org/v2/everything?q=$query&language=en&apiKey=$apiKey";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["title"] != "[Removed]") {
          String description = element["description"] ??
              "No description available"; // Provide a default value if description is null
          String imageUrl = element["urlToImage"] ??
              "https://i.postimg.cc/XqwMZy2f/noimage.jpg"; // Use a default image URL if urlToImage is null
          SearchModel searchModel = SearchModel(
            title: element["title"],
            description: description,
            url: element["url"],
            urlToImage: imageUrl,
            content: element["content"],
            author: element["author"],
            source: element["source"]["name"],
          );
          search.add(searchModel);
        }
      });
    }
  }
}
