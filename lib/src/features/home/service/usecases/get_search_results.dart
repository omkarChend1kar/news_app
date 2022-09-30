import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/src/core/utill/error/failures.dart';
import 'package:news_app/src/core/utill/usecase/usecase.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';
import 'package:news_app/src/features/home/service/repositories/homepage_repository.dart';
import 'package:news_app/src/features/home/service/usecases/home_usecase.dart';

///[Marker Interface] to get search results filtered by keywords entered in search bar
@lazySingleton
abstract class GetNewsSearchResults extends HomeUsecase
    implements UseCase<List<NewsArticleEntity>, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  ///This is a search keyword which would be passed as query
  final String query;

  const Params({required this.query});

  @override
  List<Object?> get props => [query];
}

///
///
///
class GetNewsSearchResultsImpl extends GetNewsSearchResults {
  ///
  ///
  ///
  GetNewsSearchResultsImpl({
    required this.repository,
  });

  ///
  final HomeRepository repository;

  ///
  @override
  Future<Either<Failures, List<NewsArticleEntity>>>? call(Params params) {
    return repository.getNewsSearchResults(params.query);
  }
}
