import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/injection_container.dart';
import 'package:news_app/src/features/home/view/state/bookmarkednewsarticles/bookmark_news_articles_list_notifier.dart';
import 'package:news_app/src/features/home/view/state/bookmarkednewsarticles/bookmark_news_articles_list_state.dart';
import 'package:news_app/src/features/home/view/state/remotenewsarticles/remote_news_articl_list_notifier_impl.dart';
import 'package:news_app/src/features/home/view/state/remotenewsarticles/remote_news_article_list_state.dart';

///
final remoteNewsArticleListProvider = StateNotifierProvider<
    StateNotifier<RemoteNewsArticleEntityListNotifierState>,
    RemoteNewsArticleEntityListNotifierState>(
  (ref) => sl<RemoteNewsArticleEntityListNotifierImpl>(),
);

///
final bookmarkedNewsArticleListProvider = StateNotifierProvider<
    StateNotifier<BookmarkedNewsArticleEntityListNotifierState>,
    BookmarkedNewsArticleEntityListNotifierState>(
  (ref) => sl<BookmarkedNewsArticleEntityListNotifierImpl>(),
);
