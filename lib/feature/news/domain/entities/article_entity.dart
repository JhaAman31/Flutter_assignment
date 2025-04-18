class ArticleEntity {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  ArticleEntity({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });
}

class Source {
  final String? id;
  final String? name;

  Source({required this.id, required this.name});
}
