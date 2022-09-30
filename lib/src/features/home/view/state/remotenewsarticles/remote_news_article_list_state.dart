import 'package:equatable/equatable.dart';
import 'package:news_app/src/core/utill/error/failures.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';


///[Marker Interface] abstraction for all the [RemoteNewsArticleEntityListNotifier] states
abstract class RemoteNewsArticleEntityListNotifierState extends Equatable {}

///Represents Initial State of [RemoteNewsArticleEntityListNotifierImpl]
class RemoteNewsArticleEntityListInitialState extends RemoteNewsArticleEntityListNotifierState {
  @override
  List<Object?> get props => [];
}

///Represents Loading State of [RemoteNewsArticleEntityListNotifierImpl]
class RemoteNewsArticleEntityListLoadingState extends RemoteNewsArticleEntityListNotifierState {
  @override
  List<Object?> get props => [];
}

///Represents Completed State of [RemoteNewsArticleEntityListNotifierImpl], It carries [List<NewsArticleEntity>] object
class RemoteNewsArticleEntityListCompleteState extends RemoteNewsArticleEntityListNotifierState {
  ///
  final List<NewsArticleEntity> newsArticles;

  RemoteNewsArticleEntityListCompleteState({required this.newsArticles});
  @override
  List<Object?> get props => [newsArticles];
}

///Represents Error State of [RemoteNewsArticleEntityListNotifierImpl], It carries a particular Failures
class RemoteNewsArticleEntityListErrorState extends RemoteNewsArticleEntityListNotifierState {
  ///
  final Failures failures;

  RemoteNewsArticleEntityListErrorState({required this.failures});
  @override
  List<Object?> get props => [failures];
}
