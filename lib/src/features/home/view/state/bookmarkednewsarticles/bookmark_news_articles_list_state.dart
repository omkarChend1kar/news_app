import 'package:equatable/equatable.dart';
import 'package:news_app/src/core/utill/error/failures.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';


///[Marker Interface] abstraction for all the [BookmarkedNewsArticleEntityListNotifier] states
abstract class BookmarkedNewsArticleEntityListNotifierState extends Equatable {}

///Represents Initial State of [BookmarkedNewsArticleEntityListNotifierImpl]
class BookmarkedNewsArticleEntityListInitialState extends BookmarkedNewsArticleEntityListNotifierState {
  @override
  List<Object?> get props => [];
}

///Represents Loading State of [BookmarkedNewsArticleEntityListNotifierImpl]
class BookmarkedNewsArticleEntityListLoadingState extends BookmarkedNewsArticleEntityListNotifierState {
  @override
  List<Object?> get props => [];
}

///Represents Completed State of [BookmarkedNewsArticleEntityListNotifierImpl], It carries [List<NewsArticleEntity>] object
class BookmarkedNewsArticleEntityListCompleteState extends BookmarkedNewsArticleEntityListNotifierState {
  ///
  final List<NewsArticleEntity> newsArticles;

  BookmarkedNewsArticleEntityListCompleteState({required this.newsArticles});
  @override
  List<Object?> get props => [newsArticles];
}

///Represents Error State of [BookmarkedNewsArticleEntityListNotifierImpl], It carries a particular Failures
class BookmarkedNewsArticleEntityListErrorState extends BookmarkedNewsArticleEntityListNotifierState {
  ///
  final Failures failures;

  BookmarkedNewsArticleEntityListErrorState({required this.failures});
  @override
  List<Object?> get props => [failures];
}
