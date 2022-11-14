import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './utils/blocs_handler.dart';

import 'pages/pages.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final _blocsHandler = BlocsHandler();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _blocsHandler.repositoryProviders,
      child: MultiBlocProvider(
        providers: _blocsHandler.blocProviders,
        child: MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[500],
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
