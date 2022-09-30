import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/src/core/utill/error/failures.dart';
import 'package:news_app/src/core/utill/usecase/usecase.dart';
import 'package:news_app/src/features/home/data/models/news_article_model.dart';
import 'package:news_app/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';
import 'package:news_app/src/features/home/service/repositories/homepage_repository.dart';
import 'package:news_app/src/features/home/service/usecases/home_usecase.dart';

///[Marker Interface] to add bookmarks
@lazySingleton
abstract class RemoveBookMarks extends HomeUsecase
    implements UseCase<List<NewsArticleEntity>, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  ///This is a search keyword which would be passed as query
  final NewsArticleModel newsArticleEntity;

  const Params({required this.newsArticleEntity});

  @override
  List<Object?> get props => [newsArticleEntity];
}

class RemoveBookMarksImpl extends RemoveBookMarks {
  final HomeRepository repository;

  RemoveBookMarksImpl({required this.repository});

  @override
  Future<Either<Failures, List<NewsArticleEntity>>>? call(Params params) {
    return repository.removeTheBookMark(params.newsArticleEntity);
  }
}
