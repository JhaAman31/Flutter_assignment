import 'package:flutter_assignment/feature/news/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required super.source,
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      source: SourceModel.fromJson(json['source'] ?? {}),
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "source": source,
      "author": author,
      'title': title,
      "description": description,
      "url": url,
      "urlToImage": urlToImage,
      'publishedAt': publishedAt,
    };
  }
}

class SourceModel extends Source {
  SourceModel({required super.id, required super.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(id: json['id'] ?? "", name: json['name'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
