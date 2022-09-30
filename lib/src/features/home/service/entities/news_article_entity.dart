import 'package:equatable/equatable.dart';

class NewsArticleEntity extends Equatable {
  ///Url for News headline image
  final String imageUrl;

  ///Title string for top headline of the news
  final String title;

  ///Description string for top headline of the news
  final String description;

  ///Content string for top headline of the news
  final String content;

  ///Date string for top headline of the news
  final String date;

  ///Author string for top headline of the news
  final String author;

  const NewsArticleEntity({
    required this.title,
    required this.author,
    required this.content,
    required this.date,
    required this.description,
    required this.imageUrl,
  });
  @override
  List<Object?> get props => [
        title,
        author,
        content,
        description,
        date,
        imageUrl,
      ];

}
