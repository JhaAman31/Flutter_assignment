import 'dart:convert';

import 'package:flutter_assignment/core/constants/constant.dart';
import 'package:flutter_assignment/core/error/failure.dart';
import 'package:flutter_assignment/core/error/server_exception.dart';
import 'package:flutter_assignment/feature/news/data/models/article_model.dart';

import 'package:http/http.dart' as http;

abstract interface class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines(String country);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getTopHeadlines(String country) async {
    final uri = Uri.parse(
      '${Constants.NEWS_BASE_URL}?country=${country}&apiKey=${Constants.API_KEY}',
    );
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      try {
        final body = jsonDecode(response.body);
        List<dynamic> jsonData = body['articles'];
        return jsonData.map((data) => ArticleModel.fromJson(data)).toList();
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
