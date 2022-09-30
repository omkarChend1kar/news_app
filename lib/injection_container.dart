import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/src/core/utill/network/network_info.dart';
import 'package:news_app/src/features/home/data/datasources/home_local_datasource.dart';
import 'package:news_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:news_app/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:news_app/src/features/home/service/repositories/homepage_repository.dart';
import 'package:news_app/src/features/home/service/usecases/add_bookmarks.dart';
import 'package:news_app/src/features/home/service/usecases/get_saved_bookmarks.dart';
import 'package:news_app/src/features/home/service/usecases/get_search_results.dart';
import 'package:news_app/src/features/home/service/usecases/get_top_headlines.dart';
import 'package:news_app/src/features/home/service/usecases/remove_bookmarks.dart';
import 'package:news_app/src/features/home/view/state/bookmarkednewsarticles/bookmark_news_articles_list_notifier.dart';
import 'package:news_app/src/features/home/view/state/search_query_bloc.dart';
import 'package:news_app/src/features/home/view/state/remotenewsarticles/remote_news_articl_list_notifier_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  ///
  sl.registerFactory(
    () => SearchQueryBloc(),
  );

  ///state
  sl.registerLazySingleton<RemoteNewsArticleEntityListNotifierImpl>(
    () => RemoteNewsArticleEntityListNotifierImpl(
      getTopHeadlines: sl(),
      getNewsSearchResults: sl(),
    ),
  );

  sl.registerLazySingleton<BookmarkedNewsArticleEntityListNotifierImpl>(
    () => BookmarkedNewsArticleEntityListNotifierImpl(
      addBookMarks: sl(),
      getSavedBookMarks: sl(),
      removeBookMarks: sl(),
    ),
  );

  ///Usecase
  sl.registerLazySingleton<GetTopHeadlines>(
    () => GetTopHeadlinesImpl(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetNewsSearchResults>(
    () => GetNewsSearchResultsImpl(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetSavedBookMarks>(
    () => GetSavedBookMarksImpl(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<AddBookMarks>(
    () => AddBookMarksImpl(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<RemoveBookMarks>(
    () => RemoveBookMarksImpl(
      repository: sl(),
    ),
  );

  ///Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  ///Datasources
  sl.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<HomeLocalDatasource>(
    () => HomeLocalDatasourceImpl(
      sharedPreferences: sl(),
    ),
  );

  ///External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
