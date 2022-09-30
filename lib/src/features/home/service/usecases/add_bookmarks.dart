import 'package:equatable/equatable.dart';
import 'package:news_app/src/core/utill/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/src/core/utill/usecase/usecase.dart';
import 'package:news_app/src/features/home/data/models/news_article_model.dart';
import 'package:news_app/src/features/home/service/repositories/homepage_repository.dart';
import 'package:news_app/src/features/home/service/usecases/home_usecase.dart';
import 'package:injectable/injectable.dart';

///[Marker Interface] to add bookmarks
@lazySingleton
abstract class AddBookMarks extends HomeUsecase
    implements UseCase<void, Params> {}

/// this class is used for parameter method
class Params extends Equatable {
  ///This is a search keyword which would be passed as query
  final NewsArticleModel newsArticleEntity;

  const Params({required this.newsArticleEntity});

  @override
  List<Object?> get props => [newsArticleEntity];
}

class AddBookMarksImpl extends AddBookMarks {
  final HomeRepository repository;

  AddBookMarksImpl({required this.repository});
  @override
  Future<Either<Failures, void>>? call(Params params) {
    return repository.addTheBookMark(params.newsArticleEntity);
  }
}
