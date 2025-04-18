import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/theme/app_pallete.dart';
import 'package:flutter_assignment/feature/news/domain/entities/article_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../news/presentation/screens/news_detail_screen.dart';

class BookmarkScreen extends StatefulWidget {
  final List<ArticleEntity> allArticles;

  const BookmarkScreen({super.key, required this.allArticles});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  Set<String> bookmarkedUrls = {};
  List<ArticleEntity> bookmarkedArticles = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUrls = prefs.getStringList('bookmarks')?.toSet() ?? {};

    setState(() {
      bookmarkedUrls = savedUrls;
      bookmarkedArticles = widget.allArticles
          .where((article) => bookmarkedUrls.contains(article.url))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppPallete.whiteColor,
      appBar: AppBar(

        title: Text("Bookmarks", style: TextStyle(fontWeight: FontWeight.bold, color: AppPallete.whiteColor)),
        centerTitle: true,
        backgroundColor: AppPallete.gradient3,
      ),
      body: bookmarkedArticles.isEmpty
          ? const Center(child: Text("No bookmarks yet",style: TextStyle(fontSize: 22,color: AppPallete.greyColor,fontWeight: FontWeight.w600),))
          : ListView.builder(
        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = bookmarkedArticles[index];

          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewsDetailScreen(article: article),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      article.urlToImage,
                      width: 120,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[800],
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          article.description ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          article.publishedAt != null
                              ? 'Published on ${article.publishedAt!.split("T")[0]}'
                              : '',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

