import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/features/home/view/pages/home_page.dart';
import 'package:news_app/src/features/home/view/state/home_providers.dart';
import 'injection_container.dart' as serviceLocator;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///
  await serviceLocator.init();

  ///
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ProviderScope(
        child: HomePage(
          bookMarkprovider: bookmarkedNewsArticleListProvider,
          remoteNewsprovider: remoteNewsArticleListProvider,
        ),
      ),
    );
  }
}
