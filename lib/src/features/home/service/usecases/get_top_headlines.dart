import 'package:injectable/injectable.dart';
import 'package:news_app/src/core/utill/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/src/core/utill/usecase/usecase.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';
import 'package:news_app/src/features/home/service/repositories/homepage_repository.dart';
import 'package:news_app/src/features/home/service/usecases/home_usecase.dart';

///[Marker Interface] to get top headlines [List<NewsArticleEntity>]
@lazySingleton
abstract class GetTopHeadlines extends HomeUsecase
    implements UseCase<List<NewsArticleEntity>, NoParams> {}

///
///
///
class GetTopHeadlinesImpl extends GetTopHeadlines {
  ///
  ///
  ///
  GetTopHeadlinesImpl({
    required this.repository,
  });

  ///
  final HomeRepository repository;

  ///
  @override
  Future<Either<Failures, List<NewsArticleEntity>>>? call(NoParams params) {
    return repository.getTopHeadlines();
  }
}
