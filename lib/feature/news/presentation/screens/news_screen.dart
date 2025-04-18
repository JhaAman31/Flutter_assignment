import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/theme/app_pallete.dart';
import 'package:flutter_assignment/feature/news/domain/entities/article_entity.dart';
import 'package:flutter_assignment/feature/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_assignment/feature/news/presentation/bloc/news_event.dart';
import 'package:flutter_assignment/feature/news/presentation/bloc/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Set<String> bookmarkedUrls = {};

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarkedUrls = prefs.getStringList('bookmarks')?.toSet() ?? {};
    });
  }

  Future<void> _toggleBookmark(ArticleEntity article) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (bookmarkedUrls.contains(article.url)) {
        bookmarkedUrls.remove(article.url);
      } else {
        bookmarkedUrls.add(article.url);
      }
      prefs.setStringList('bookmarks', bookmarkedUrls.toList());
    });
  }

  bool isBookmarked(String url) {
    return bookmarkedUrls.contains(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppPallete.whiteColor,
      appBar: AppBar(
        title: Text("News",style: TextStyle(fontWeight: FontWeight.bold,color: AppPallete.whiteColor),),
        centerTitle: true,
        backgroundColor: AppPallete.gradient3,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsIdle) {
            context.read<NewsBloc>().add(FetchArticles(country: 'us'));
            return const Center(child: CircularProgressIndicator(color:AppPallete.gradient2,));
          } else if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator(color:AppPallete.gradient2,));
          } else if (state is NewsSuccess) {
            return _buildProductList(context, state.article);
          } else if (state is NewsError) {
            return Center(child: Text(state.error));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProductList(BuildContext context, List<ArticleEntity> articles) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsBloc>().add(FetchArticles(country: 'us'));
        await _loadBookmarks();
      },
      child: ListView.separated(
        itemCount: articles.length,
        physics: BouncingScrollPhysics(),
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final article = articles[index];
          final bookmarked = isBookmarked(article.url);

          return InkWell(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsDetailScreen(article: article,),
                  ),
                ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      article.urlToImage,
                      width: 120,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[800],
                            child: const Icon(Icons.image_not_supported),
                          ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Info
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              article.publishedAt != null
                                  ? 'Published on ${article.publishedAt!.split("T")[0]}'
                                  : '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                bookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: bookmarked ? Colors.blue : Colors.grey,
                              ),
                              onPressed: () => _toggleBookmark(article),
                            ),
                          ],
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
