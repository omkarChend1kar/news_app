import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';
import 'package:intl/intl.dart';

///
class NewsArticleModel extends NewsArticleEntity {
  const NewsArticleModel({
    required super.title,
    required super.author,
    required super.content,
    required super.date,
    required super.description,
    required super.imageUrl,
  });

  static NewsArticleModel fromJson(Map<String, dynamic> jsonMap) {
    return NewsArticleModel(
      title: jsonMap['title'],
      author: jsonMap['source']['name'],
      content: jsonMap['content'],
      //
      date: DateFormat.yMMMd().format(DateTime.parse(jsonMap['publishedAt'])),
      description: jsonMap['description'],
      imageUrl: jsonMap['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'content': content,
      'date': date,
      'description': description,
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}
