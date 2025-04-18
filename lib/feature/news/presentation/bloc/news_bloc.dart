
import 'package:flutter_assignment/core/error/failure.dart';
import 'package:flutter_assignment/feature/news/domain/entities/article_entity.dart';
import 'package:flutter_assignment/feature/news/domain/usecase/get_news_usecase.dart';
import 'package:flutter_assignment/feature/news/presentation/bloc/news_event.dart';
import 'package:flutter_assignment/feature/news/presentation/bloc/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase useCase;

  NewsBloc({required this.useCase}) : super(NewsIdle()) {
    on<FetchArticles>(_onFetchArticles);
  }

  Future<void> _onFetchArticles(
    FetchArticles event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());

    final Either<Failure, List<ArticleEntity>> article = await useCase.call(
      event.country,
    );
    article.fold(
      (error) => emit(NewsError(error: error.errorMessage)),
      (data) => emit(NewsSuccess(article: data)),
    );
  }
}
