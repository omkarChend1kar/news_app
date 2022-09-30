import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/src/core/utill/error/failures.dart';
import 'package:news_app/src/core/utill/usecase/usecase.dart';
import 'package:news_app/src/features/home/service/usecases/get_search_results.dart';
import 'package:news_app/src/features/home/service/usecases/get_top_headlines.dart';
import 'package:news_app/src/features/home/view/state/home_notifier.dart';
import 'package:news_app/src/features/home/view/state/remotenewsarticles/remote_news_article_list_state.dart';

///
///
///
@lazySingleton
class RemoteNewsArticleEntityListNotifierImpl
    extends StateNotifier<RemoteNewsArticleEntityListNotifierState>
    implements RemoteNewsArticleEntityListNotifier {
  ///
  ///
  ///
  RemoteNewsArticleEntityListNotifierImpl({
    required this.getTopHeadlines,
    required this.getNewsSearchResults,
  }) : super(RemoteNewsArticleEntityListInitialState()) {
    notifyNewsArticleEntityListWithTopHeadlines();
  }

  ///
  final GetTopHeadlines getTopHeadlines;

  ///
  final GetNewsSearchResults getNewsSearchResults;

  @override
  notifyNewsArticleEntityListWithSearchResults(String? query) {
    if (query == null) {
      state = RemoteNewsArticleEntityListErrorState(
        failures:
            const ServerFailure(message: 'Could Not get the Search query'),
      );
      return;
    }
    if (query.isEmpty) {
      state = RemoteNewsArticleEntityListErrorState(
        failures: const ServerFailure(message: 'Please enter a search keyword'),
      );
    }

    ///
    final request = getNewsSearchResults(Params(query: query));

    ///
    request!.then((response) {
      response.fold(
        (l) {
          state = RemoteNewsArticleEntityListErrorState(failures: l);
        },
        (r) {
          state = RemoteNewsArticleEntityListCompleteState(newsArticles: r);
        },
      );
    });
  }

  @override
  notifyNewsArticleEntityListWithTopHeadlines() {
    ///
    final request = getTopHeadlines(NoParams());

    ///
    request!.then((response) {
      response.fold(
        (l) {
          state = RemoteNewsArticleEntityListErrorState(failures: l);
        },
        (r) {
          state = RemoteNewsArticleEntityListCompleteState(newsArticles: r);
        },
      );
    });
  }
}
