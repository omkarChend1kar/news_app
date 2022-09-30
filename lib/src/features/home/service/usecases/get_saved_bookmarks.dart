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

///[Marker Interface] to get saved bookmarks
@lazySingleton
abstract class GetSavedBookMarks extends HomeUsecase
    implements UseCase<List<NewsArticleEntity>, NoParams> {}

class GetSavedBookMarksImpl extends GetSavedBookMarks {
  final HomeRepository repository;

  GetSavedBookMarksImpl({required this.repository});

  @override
  Future<Either<Failures, List<NewsArticleEntity>>>? call(NoParams params) {
    return repository.getSavedBookmarks();
  }
}
