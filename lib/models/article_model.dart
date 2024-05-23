class ArticleModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  String? source;
  String? id;
  String? imageFire;
  String? titleFire;
  String? sourceFire;

  ArticleModel(
      {this.author,
      this.content,
      this.description,
      this.title,
      this.url,
      this.urlToImage,
      this.source}) {
    id = url;
    imageFire = urlToImage;
    titleFire = title;
    sourceFire = source;
  }
}
