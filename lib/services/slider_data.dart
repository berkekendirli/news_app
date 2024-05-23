import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/services/api_key.dart';

class Sliders {
  List<sliderModel> sliders = [];

  Future<void> getSlider() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&pageSize=100&apiKey=$newsApiKey";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["title"] != "[Removed]") {
          String description = element["description"] ??
              ""; // Provide a default value if description is null
          String imageUrl = element["urlToImage"] ??
              "https://i.ibb.co/q7bYPKN/placeholder-image21.png"; // Use a default image URL if urlToImage is null
          sliderModel slidermodel = sliderModel(
            title: element["title"],
            description: description,
            url: element["url"],
            urlToImage: imageUrl,
            content: element["content"],
            author: element["author"],
            source: element["source"]["name"],
          );
          sliders.add(slidermodel);
        }
      });
    }
  }
}
