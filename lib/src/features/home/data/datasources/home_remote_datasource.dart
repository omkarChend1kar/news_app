import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/src/core/utill/error/exceptions.dart';
import 'package:news_app/src/features/home/data/models/news_article_model.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';

@lazySingleton
abstract class HomeRemoteDatasource {
  ///
  ///
  ///
  Future<List<NewsArticleEntity>>? getTopHeadlines();

  ///
  ///
  ///
  Future<List<NewsArticleEntity>>? getNewsSearchResults(String? query);
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final http.Client client;

  HomeRemoteDatasourceImpl({required this.client});
  @override
  Future<List<NewsArticleEntity>>? getNewsSearchResults(String? query) async {
    final searchEndpoint =
        'https://gnews.io/api/v4/search?q=$query&lang=en&token=59693127be8978f105c4f987b576eeff';

    ///
    final request = await client.get(Uri.parse(searchEndpoint));

    ///
    if (request.statusCode == 200) {
      ///
      Map<String, dynamic> topArticlesJson = jsonDecode(request.body);

      ///
      final List<dynamic> articles = topArticlesJson['articles'];

      final List<NewsArticleModel> topHeadlines =
          articles.map((e) => NewsArticleModel.fromJson(e)).toList();

      ///
      return Future(() => topHeadlines);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NewsArticleEntity>>? getTopHeadlines() async {
    const topArticlesEndpoint =
        'https://gnews.io/api/v4/top-headlines?lang=en&token=59693127be8978f105c4f987b576eeff';

    ///
    final Response response = await client.get(
      Uri.parse(topArticlesEndpoint),
    );

    ///
    if (response.statusCode == 200) {
      ///
      Map<String, dynamic> topArticlesJson = jsonDecode(response.body);

      ///
      final List<dynamic> articles = topArticlesJson['articles'];

      final List<NewsArticleModel> topHeadlines =
          articles.map((e) => NewsArticleModel.fromJson(e)).toList();

      ///
      return Future(() => topHeadlines);
    } else {
      throw Exception();
    }
  }
}
