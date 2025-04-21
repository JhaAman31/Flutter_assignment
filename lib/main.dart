import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/internet/connection_checker.dart';
import 'package:flutter_assignment/feature/login/login_screen.dart';
import 'package:flutter_assignment/feature/news/data/data_source/local_data_source.dart';
import 'package:flutter_assignment/feature/news/data/data_source/remote_data_source.dart';
import 'package:flutter_assignment/feature/news/data/repositories/news_repository_impl.dart';
import 'package:flutter_assignment/feature/news/domain/repositories/news_repository.dart';
import 'package:flutter_assignment/feature/news/domain/usecase/get_news_usecase.dart';
import 'package:flutter_assignment/feature/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_assignment/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/global.dart';

final bloc = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // External Dependencies
  final sharedPreference = await SharedPreferences.getInstance();
  bloc.registerLazySingleton(() => sharedPreference);
  bloc.registerLazySingleton(() => http.Client());
  bloc.registerLazySingleton(() => InternetConnection());

  // DataSources ( Interfaces )
  bloc.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(preferences: bloc()),
  );
  bloc.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: bloc()),
  );
  bloc.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(bloc()),
  );

  // Repository
  bloc.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: bloc(),
      localDataSource: bloc(),
      connection: bloc(),
    ),
  );

  // UseCase
  bloc.registerLazySingleton(() => GetNewsUseCase(repository: bloc()));

  // Bloc
  bloc.registerFactory(() => NewsBloc(useCase: bloc()));

  final isLoggedIn = sharedPreference.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home:
          widget.isLoggedIn
              ? HomeScreen()
              : LoginScreen(),
    );
  }
}
