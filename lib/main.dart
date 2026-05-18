import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';

import 'data/models/article_model.dart';
import 'data/models/custom_article_model.dart';
import 'data/services/news_api_service.dart';
import 'data/services/local_storage_service.dart';
import 'data/services/custom_articles_service.dart';
import 'data/repositories/news_repository.dart';
import 'presentation/bloc/news_bloc/news_bloc.dart';
import 'presentation/bloc/favorites_bloc/favorites_bloc.dart';
import 'presentation/bloc/custom_articles_bloc/custom_articles_bloc.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Register the adapters for both models
  Hive.registerAdapter(ArticleModelAdapter());
  Hive.registerAdapter(CustomArticleModelAdapter());
  
  // Initialize local storage services
  final localStorageService = LocalStorageService();
  await localStorageService.init();
  
  final customArticlesService = CustomArticlesService();
  await customArticlesService.init();
  
  runApp(MyApp(
    localStorageService: localStorageService,
    customArticlesService: customArticlesService,
  ));
}

class MyApp extends StatelessWidget {
  final LocalStorageService localStorageService;
  final CustomArticlesService customArticlesService;

  const MyApp({
    Key? key,
    required this.localStorageService,
    required this.customArticlesService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create instances of services
    final dio = Dio();
    final apiService = NewsApiService(dio);
    final repository = NewsRepository(apiService, localStorageService);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: repository),
        RepositoryProvider.value(value: customArticlesService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsBloc(repository),
          ),
          BlocProvider(
            create: (context) => FavoritesBloc(repository),
          ),
          BlocProvider(
            create: (context) => CustomArticlesBloc(customArticlesService),
          ),
        ],
        child: MaterialApp(
          title: 'Smart News Digest',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              centerTitle: false,
              elevation: 0,
            ),
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
