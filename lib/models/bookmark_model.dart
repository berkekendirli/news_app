class BookmarkedNews {
  final String title;
  final String url;
  final String sourceName;
  final String userId; 
  const BookmarkedNews({
    required this.title,
    required this.url,
    required this.sourceName,
    
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'sourceName': sourceName,
      'userId': userId,
    };
  }
}
