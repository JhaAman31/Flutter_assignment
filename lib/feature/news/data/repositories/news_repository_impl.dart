import 'package:flutter_assignment/core/error/failure.dart';
import 'package:flutter_assignment/core/error/server_exception.dart';
import 'package:flutter_assignment/core/internet/connection_checker.dart';
import 'package:flutter_assignment/feature/news/data/data_source/local_data_source.dart';
import 'package:flutter_assignment/feature/news/data/data_source/remote_data_source.dart';
import 'package:flutter_assignment/feature/news/data/models/article_model.dart';
import 'package:flutter_assignment/feature/news/domain/repositories/news_repository.dart';
import 'package:fpdart/src/either.dart';


class NewsRepositoryImpl implements NewsRepository{
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final ConnectionChecker connection;

  NewsRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.connection});

  @override
  Future<Either<Failure, List<ArticleModel>>> getTopHeadlines(String country) async{
   if(await connection.isConnected){
     try{
       final response = await remoteDataSource.getTopHeadlines(country);
       localDataSource.getCacheNews(response);

       return Right(response);

     }on ServerException{
       throw ServerFailure(errorMessage: "Something might be wrong with Backend");
     }

   }else{
     try{
       final cacheResponse = await localDataSource.lastNews();

       return Right(cacheResponse);
     }on CacheException{
       throw ConnectionFailure(errorMessage: "Internet is not connected");
     }

   }
  }
}