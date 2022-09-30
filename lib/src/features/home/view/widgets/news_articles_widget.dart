import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/injection_container.dart';
import 'package:news_app/src/features/home/view/pages/detailed_news_page.dart';
import 'package:news_app/src/features/home/view/state/bookmarkednewsarticles/bookmark_news_articles_list_notifier.dart';
import 'package:news_app/src/features/home/view/state/remotenewsarticles/remote_news_article_list_state.dart';

class NewsArticlesWidget extends ConsumerWidget {
  const NewsArticlesWidget({super.key, required this.provider});

  final StateNotifierProvider<
      StateNotifier<RemoteNewsArticleEntityListNotifierState>,
      RemoteNewsArticleEntityListNotifierState> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    final state = ref.watch(provider);

    ///
    if (state is RemoteNewsArticleEntityListInitialState) {
      return const Center(child: CircularProgressIndicator());
    }

    ///
    if (state is RemoteNewsArticleEntityListCompleteState) {
      final listOfArticles = state.newsArticles;
      return ListView.builder(
        itemCount: listOfArticles.length,
        itemBuilder: (context, index) {
          final news = listOfArticles[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedNewsPage(
                        news: news,
                      ),
                    ),
                  );
                },
                leading: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      news.imageUrl,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.running_with_errors);
                      },
                    ),
                  ),
                ),
                title: Text(news.title),
                subtitle: Text(news.date),
                trailing: IconButton(
                  onPressed: () {
                    sl<BookmarkedNewsArticleEntityListNotifierImpl>()
                        .notifyNewsArticleEntityListWithAddedBookMarks(
                      news,
                    );
                  },
                  icon: const Icon(Icons.bookmark_add_outlined),
                ),
              ),
            ),
          );
        },
      );
    }

    ///
    if (state is RemoteNewsArticleEntityListErrorState) {
      return Text(state.failures.message!);
    }
    return const SizedBox();
  }
}
