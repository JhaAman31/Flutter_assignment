import 'package:flutter_assignment/core/error/failure.dart';
import 'package:flutter_assignment/feature/news/domain/entities/article_entity.dart';
import 'package:fpdart/fpdart.dart';


abstract interface class NewsRepository{
   Future<Either<Failure,List<ArticleEntity>>> getTopHeadlines(String country);
}