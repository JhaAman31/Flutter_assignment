import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable{
  const NewsEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchArticles extends NewsEvent{
  final String country;

  FetchArticles({required this.country});
}