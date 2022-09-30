import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/src/core/utill/error/failures.dart';
import 'package:news_app/src/features/home/data/models/news_article_model.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';

///Abstraction of home page repository
@lazySingleton
abstract class HomeRepository {
  ///To get the Top Headlines over gnews remote api Top Headline Endpoint
  Future<Either<Failures, List<NewsArticleEntity>>>? getTopHeadlines();

  ///To get the Search results Filtered by given search query/keywords
  Future<Either<Failures, List<NewsArticleEntity>>>? getNewsSearchResults(
      String? query);

  ///
  Future<Either<Failures, List<NewsArticleModel>>>? getSavedBookmarks();

  ///
  Future<Either<Failures, void>>? addTheBookMark(
      NewsArticleModel? newsArticle);

  ///
  Future<Either<Failures, List<NewsArticleModel>>>? removeTheBookMark(
      NewsArticleModel? newsArticle);
}
