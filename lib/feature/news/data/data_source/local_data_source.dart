import 'dart:convert';

import 'package:flutter_assignment/core/constants/constant.dart';
import 'package:flutter_assignment/core/error/server_exception.dart';
import 'package:flutter_assignment/feature/news/data/models/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class NewsLocalDataSource {
  Future<void>? getCacheNews(List<ArticleModel>? model);

  Future<List<ArticleModel>> lastNews();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final SharedPreferences preferences;

  NewsLocalDataSourceImpl({required this.preferences});

  @override
  Future<void>? getCacheNews(List<ArticleModel>? model) {
    if (model != null) {
      final cacheNews = model.map((e) => e.toJson()).toList();
      preferences.setString(Constants.CACHE_NEWS, jsonEncode(cacheNews));
    } else {
      throw CacheException();
    }
    return null;
  }

  @override
  Future<List<ArticleModel>> lastNews() {
    final cache = preferences.getString(Constants.CACHE_NEWS);
    if (cache != null) {
      final List lastNews = jsonDecode(cache);
      return Future.value(
        lastNews.map((data) => ArticleModel.fromJson(data)).toList(),
      );
    } else {
      throw CacheException();
    }
  }
}
