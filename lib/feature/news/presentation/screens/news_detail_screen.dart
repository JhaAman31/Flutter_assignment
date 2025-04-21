import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/theme/app_pallete.dart';
import 'package:flutter_assignment/feature/news/domain/entities/article_entity.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailScreen extends StatelessWidget {
  final ArticleEntity article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: AppBar(
        backgroundColor: AppPallete.gradient3,
        title: Text(
          article.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppPallete.whiteColor,
          ),
        ),
        iconTheme: IconThemeData(color: AppPallete.whiteColor),
      ),
      body: WebViewWidget(
        controller: WebViewController()..loadRequest(Uri.parse(article.url)),
      ),
    );
  }
}
