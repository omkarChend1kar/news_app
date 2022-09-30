import 'dart:async';
import 'package:news_app/injection_container.dart';
import 'package:news_app/src/features/home/view/state/remotenewsarticles/remote_news_articl_list_notifier_impl.dart';

class SearchQueryBloc {
  ///
  final _searchQueryStreamController = StreamController<String>.broadcast();

  ///
  Function(String query) get searchQuerySink =>
      _searchQueryStreamController.sink.add;

  ///
  Stream<String> get searchQueryStream => _searchQueryStreamController.stream;

  ///Service locator registered object of [RemoteNewsArticleEntityListNotifierImpl] 
  ///to access behavoir that enables search results
  final RemoteNewsArticleEntityListNotifierImpl notifier =
      sl<RemoteNewsArticleEntityListNotifierImpl>();

  ///constructor
  SearchQueryBloc() {
    getSearchResults();
  }

  ///Setup listener to [searchQueryStream] to get search query in 
  ///realtime and fetch news articles filtered with search query
  void getSearchResults() {
    searchQueryStream.listen((query) {
      notifier.notifyNewsArticleEntityListWithSearchResults(query);
    });
  }

  ///
  dispose() {
    _searchQueryStreamController.close();
  }
}
