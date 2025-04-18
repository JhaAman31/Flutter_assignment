import 'package:equatable/equatable.dart';
import 'package:flutter_assignment/feature/news/domain/entities/article_entity.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsIdle extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<ArticleEntity> article;

  const NewsSuccess({required this.article});

  @override
  // TODO: implement props
  List<Object?> get props => [article];
}

class NewsError extends NewsState {
  final String error;

  const NewsError({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
