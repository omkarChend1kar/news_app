import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/injection_container.dart';
import 'package:news_app/src/features/home/view/state/bookmarkednewsarticles/bookmark_news_articles_list_state.dart';
import 'package:news_app/src/features/home/view/state/remotenewsarticles/remote_news_articl_list_notifier_impl.dart';
import 'package:news_app/src/features/home/view/state/remotenewsarticles/remote_news_article_list_state.dart';
import 'package:news_app/src/features/home/view/widgets/bookmarks_list_widget.dart';
import 'package:news_app/src/features/home/view/widgets/news_articles_widget.dart';
import 'package:news_app/src/features/home/view/widgets/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.remoteNewsprovider,
    required this.bookMarkprovider,
  });

  ///
  final StateNotifierProvider<
      StateNotifier<RemoteNewsArticleEntityListNotifierState>,
      RemoteNewsArticleEntityListNotifierState> remoteNewsprovider;

  ///
  final StateNotifierProvider<
      StateNotifier<BookmarkedNewsArticleEntityListNotifierState>,
      BookmarkedNewsArticleEntityListNotifierState> bookMarkprovider;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NewsApp'),
          centerTitle: true,
          bottom: TabBar(
            onTap: (value) {
              sl<RemoteNewsArticleEntityListNotifierImpl>()
                  .notifyNewsArticleEntityListWithTopHeadlines();
            },
            tabs: const [
              Tab(
                text: 'TopHeadlines',
              ),
              Tab(
                text: 'Bookmarks',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 70,
                    width: double.maxFinite,
                    child: SearchBarWidget(),
                  ),
                  Expanded(
                    child: NewsArticlesWidget(provider: remoteNewsprovider),
                  ),
                ],
              ),
            ),
            BookmarkListWidget(provider: bookMarkprovider)
          ],
        ),
      ),
    );
  }
}
