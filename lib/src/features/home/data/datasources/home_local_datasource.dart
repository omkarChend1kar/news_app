import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/src/core/utill/error/exceptions.dart';
import 'package:news_app/src/features/home/data/models/news_article_model.dart';
import 'package:news_app/src/features/home/service/entities/news_article_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SAVED_BOOKMARKS = 'bookmarks';

@lazySingleton
abstract class HomeLocalDatasource {
  ///
  Future<void>? addTheBookmark(NewsArticleModel? newsArticle);

  ///
  Future<List<NewsArticleModel>>? removeTheBookmark(
      NewsArticleModel? newsArticle);

  ///
  Future<List<NewsArticleModel>>? getSavedBookmarks();
}

///
class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  ///
  HomeLocalDatasourceImpl({required this.sharedPreferences});

  ///
  final SharedPreferences sharedPreferences;
  @override
  Future<void>? addTheBookmark(NewsArticleModel? newsArticle) {
    ///
    final jsonString = sharedPreferences.getString(SAVED_BOOKMARKS);

    if (jsonString != null) {
      ///
      final List jsonMaps = jsonDecode(jsonString);

      ///
      final List<NewsArticleModel> bookmarks = jsonMaps
          .map(
            (e) => NewsArticleModel(
              title: e['title'],
              author: e['author'],
              content: e['content'],
              date: e['date'],
              description: e['description'],
              imageUrl: e['imageUrl'],
            ),
          )
          .toList();

      ///
      if (newsArticle != null) {
        ///
        bookmarks.add(newsArticle);

        ///
        final List<Map<String, dynamic>> listOfJson = bookmarks
            .map((e) => e.toJson())
            .toList()
            .cast<Map<String, dynamic>>();

        ///
        final newJsonString = jsonEncode(listOfJson);

        ///
        return sharedPreferences.setString(SAVED_BOOKMARKS, newJsonString);
      }
    } else {
      ///
      final List emptyBookMarks = [];

      ///
      if (newsArticle != null) {
        ///
        emptyBookMarks.add(newsArticle.toJson());

        ///
        final newJsonString = jsonEncode(emptyBookMarks);

        ///
        return sharedPreferences.setString(SAVED_BOOKMARKS, newJsonString);
      }
    }
    return null;
  }

  @override
  Future<List<NewsArticleModel>>? removeTheBookmark(
      NewsArticleEntity? newsArticle) {
    ///
    final jsonString = sharedPreferences.getString(SAVED_BOOKMARKS);

    ///
    final List jsonMaps = jsonDecode(jsonString!);

    ///
    final List<NewsArticleModel> bookmarks = jsonMaps
        .map(
          (e) => NewsArticleModel(
            title: e['title'],
            author: e['author'],
            content: e['content'],
            date: e['date'],
            description: e['description'],
            imageUrl: e['imageUrl'],
          ),
        )
        .toList();

    ///
    bookmarks.removeWhere((element) => element == newsArticle);

    ///
    final List<Map<String, dynamic>> listOfJson =
        bookmarks.map((e) => e.toJson()).toList().cast<Map<String, dynamic>>();

    ///
    final newJsonString = jsonEncode(listOfJson);

    ///
    sharedPreferences.setString(SAVED_BOOKMARKS, newJsonString);

    final getJsonStringAgain = sharedPreferences.getString(SAVED_BOOKMARKS);

    if (getJsonStringAgain != null) {
      ///
      final List jsonMaps = jsonDecode(jsonString);

      ///
      final List<NewsArticleModel> bookmarks = jsonMaps
          .map(
            (e) => NewsArticleModel(
              title: e['title'],
              author: e['author'],
              content: e['content'],
              date: e['date'],
              description: e['description'],
              imageUrl: e['imageUrl'],
            ),
          )
          .toList();

      ///
      return Future(
        () => bookmarks,
      );
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<NewsArticleModel>>? getSavedBookmarks() {
    ///
    final jsonString = sharedPreferences.getString(SAVED_BOOKMARKS);

    if (jsonString != null) {
      ///
      final List jsonMaps = jsonDecode(jsonString);

      ///
      final List<NewsArticleModel> bookmarks = jsonMaps
          .map(
            (e) => NewsArticleModel(
              title: e['title'],
              author: e['author'],
              content: e['content'],
              date: e['date'],
              description: e['description'],
              imageUrl: e['imageUrl'],
            ),
          )
          .toList();

      ///
      return Future(
        () => bookmarks,
      );
    } else {
      throw CacheException();
    }
  }
}
