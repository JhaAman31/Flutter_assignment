import 'package:flutter_assignment/core/error/failure.dart';
import 'package:flutter_assignment/feature/news/domain/entities/article_entity.dart';
import 'package:flutter_assignment/feature/news/domain/repositories/news_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase({required this.repository});

  Future<Either<Failure, List<ArticleEntity>>> call(String country) {
    return repository.getTopHeadlines(country);
  }
}
