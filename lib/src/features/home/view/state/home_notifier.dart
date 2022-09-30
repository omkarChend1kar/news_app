import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';

///[Marker Interface] abstraction for all the home notifiers
abstract class HomeNotifier {}

///abstraction to get List<NewsArticleEntity>
abstract class RemoteNewsArticleEntityListNotifier extends HomeNotifier {
  ///abstract behavior to emit [List<NewsArticleEntity>] of search results
  notifyNewsArticleEntityListWithSearchResults(String? query);

  ///abstract behavior to emit [List<NewsArticleEntity>] of top headlines
  notifyNewsArticleEntityListWithTopHeadlines();
}

///abstraction to get topic entities by name from course entity
abstract class BookmarkedNewsArticleEntityListNotifier extends HomeNotifier {
  ///abstract behavior to retrieve saved bookmarks from [SharedPreferences]
  notifyNewsArticleEntityListWithSavedBookMarks();

  ///abstract behavior to add new bookmarks to [SharedPreferences]
  notifyNewsArticleEntityListWithAddedBookMarks(NewsArticleEntity? newsArticle);

  ///abstract behavior to remove  bookmarks from [SharedPreferences]
  notifyNewsArticleEntityListWithRemovedBookMarks(
    NewsArticleEntity? newsArticle,
  );
}
