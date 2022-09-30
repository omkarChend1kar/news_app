import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/injection_container.dart';
import 'package:news_app/src/features/home/view/pages/detailed_news_page.dart';
import 'package:news_app/src/features/home/view/state/bookmarkednewsarticles/bookmark_news_articles_list_notifier.dart';
import 'package:news_app/src/features/home/view/state/bookmarkednewsarticles/bookmark_news_articles_list_state.dart';

class BookmarkListWidget extends ConsumerWidget {
  const BookmarkListWidget({
    required this.provider,
    super.key,
  });

  final StateNotifierProvider<
      StateNotifier<BookmarkedNewsArticleEntityListNotifierState>,
      BookmarkedNewsArticleEntityListNotifierState> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    final state = ref.watch(provider);

    ///
    if (state is BookmarkedNewsArticleEntityListInitialState) {
      return const Center(child: CircularProgressIndicator());
    }

    ///
    if (state is BookmarkedNewsArticleEntityListCompleteState) {
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
                    ///
                    sl<BookmarkedNewsArticleEntityListNotifierImpl>()
                        .notifyNewsArticleEntityListWithRemovedBookMarks(
                      news,
                    );
                  },
                  icon: const Icon(Icons.delete_forever),
                ),
              ),
            ),
          );
        },
      );
    }

    ///
    if (state is BookmarkedNewsArticleEntityListErrorState) {
      return Text(state.failures.message!);
    }
    return const SizedBox();
  }
}
