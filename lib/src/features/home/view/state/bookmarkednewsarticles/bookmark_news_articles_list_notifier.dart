import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/src/core/utill/usecase/usecase.dart';
import 'package:news_app/src/features/home/data/models/news_article_model.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';
import 'package:news_app/src/features/home/service/usecases/add_bookmarks.dart'
    as addBookMark;
import 'package:news_app/src/features/home/service/usecases/get_saved_bookmarks.dart';
import 'package:news_app/src/features/home/service/usecases/remove_bookmarks.dart';
import 'package:news_app/src/features/home/view/state/bookmarkednewsarticles/bookmark_news_articles_list_state.dart';
import 'package:news_app/src/features/home/view/state/home_notifier.dart';

///
///
///
@lazySingleton
class BookmarkedNewsArticleEntityListNotifierImpl
    extends StateNotifier<BookmarkedNewsArticleEntityListNotifierState>
    implements BookmarkedNewsArticleEntityListNotifier {
  ///
  ///
  ///
  BookmarkedNewsArticleEntityListNotifierImpl({
    required this.addBookMarks,
    required this.getSavedBookMarks,
    required this.removeBookMarks,
  }) : super(BookmarkedNewsArticleEntityListInitialState()) {
    notifyNewsArticleEntityListWithSavedBookMarks();
  }

  ///
  final addBookMark.AddBookMarks addBookMarks;

  ///
  final GetSavedBookMarks getSavedBookMarks;

  ///
  final RemoveBookMarks removeBookMarks;

  @override
  notifyNewsArticleEntityListWithAddedBookMarks(
      NewsArticleEntity? newsArticle) {
    if (newsArticle != null) {
      ///
      final NewsArticleModel model = NewsArticleModel(
        title: newsArticle.title,
        author: newsArticle.author,
        content: newsArticle.content,
        date: newsArticle.date,
        description: newsArticle.description,
        imageUrl: newsArticle.imageUrl,
      );

      ///
      final addBookMarkUseCase = addBookMarks(
        addBookMark.Params(newsArticleEntity: model),
      );

      ///
      addBookMarkUseCase!.then((either) {
        either.fold((l) {
          state = BookmarkedNewsArticleEntityListErrorState(failures: l);
        }, (r) {});
      });
    }

    ///
    notifyNewsArticleEntityListWithSavedBookMarks();
  }

  @override
  notifyNewsArticleEntityListWithRemovedBookMarks(
      NewsArticleEntity? newsArticle) {
    if (newsArticle != null) {
      ///
      final NewsArticleModel model = NewsArticleModel(
        title: newsArticle.title,
        author: newsArticle.author,
        content: newsArticle.content,
        date: newsArticle.date,
        description: newsArticle.description,
        imageUrl: newsArticle.imageUrl,
      );

      ///
      final removeBookmarkCase = removeBookMarks(
        Params(newsArticleEntity: model),
      );

      ///
      removeBookmarkCase!.then((either) {
        either.fold((l) {
          state = BookmarkedNewsArticleEntityListErrorState(failures: l);
        }, (r) {
          state = BookmarkedNewsArticleEntityListCompleteState(newsArticles: r);
        });
      });
    }
    notifyNewsArticleEntityListWithSavedBookMarks();
  }

  @override
  notifyNewsArticleEntityListWithSavedBookMarks() {
    ///
    final getSavedBookMarksUseCase = getSavedBookMarks(NoParams());

    ///
    getSavedBookMarksUseCase!.then((response) {
      response.fold((l) {
        state = BookmarkedNewsArticleEntityListErrorState(failures: l);
      }, (r) {
        state = BookmarkedNewsArticleEntityListCompleteState(newsArticles: r);
      });
    });
  }
}
