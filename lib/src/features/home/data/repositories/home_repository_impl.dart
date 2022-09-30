import 'package:news_app/src/core/utill/error/exceptions.dart';
import 'package:news_app/src/core/utill/network/network_info.dart';
import 'package:news_app/src/features/home/data/datasources/home_local_datasource.dart';
import 'package:news_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:news_app/src/features/home/data/models/news_article_model.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';
import 'package:news_app/src/core/utill/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/src/features/home/service/repositories/homepage_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource remoteDataSource;
  final HomeLocalDatasource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failures, List<NewsArticleEntity>>>? getNewsSearchResults(
      String? query) async {
    if (await networkInfo.isConnected!) {
      try {
        return Right(
          await remoteDataSource.getNewsSearchResults(query)!,
        );
      } on Exception {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworFailure(message: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<Failures, List<NewsArticleEntity>>>? getTopHeadlines() async {
    if (await networkInfo.isConnected!) {
      try {
        return Right(
          await remoteDataSource.getTopHeadlines()!,
        );
      } on Exception {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworFailure(message: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<Failures, List<NewsArticleModel>>>? getSavedBookmarks() async {
    try {
      return Right(
        await localDataSource.getSavedBookmarks()!,
      );
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failures, void>>? addTheBookMark(
      NewsArticleModel? newsArticle) async {
    try {
      return Right(
        await localDataSource.addTheBookmark(newsArticle)!,
      );
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failures, List<NewsArticleModel>>>? removeTheBookMark(
      NewsArticleModel? newsArticle) async {
    try {
      return Right(
        await localDataSource.removeTheBookmark(newsArticle)!,
      );
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
