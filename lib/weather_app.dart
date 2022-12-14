import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './utils/blocs_handler.dart';
import './utils/routes_handler.dart';
import 'blocs/blocs.dart';
import 'pages/pages.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final _blocsHandler = BlocsHandler();
  final _routesHandler = RoutesHandler();

  void _weatherListener(BuildContext ctx, WeatherState state) {
    ctx.read<ThemeBloc>().add(SetThemeEvent(temp: state.weather.temp));
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _blocsHandler.repositoryProviders,
      child: MultiBlocProvider(
        providers: _blocsHandler.blocProviders,
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: _weatherListener,
          child: BlocSelector<ThemeBloc, ThemeState, AppTheme>(
            selector: (state) => state.appTheme,
            builder: (ctx, appTheme) => MaterialApp(
              title: 'Weather App',
              debugShowCheckedModeBanner: false,
              themeMode:
                  appTheme == AppTheme.light ? ThemeMode.light : ThemeMode.dark,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              initialRoute: HomePage.id,
              routes: _routesHandler.routes,
            ),
          ),
        ),
      ),
    );
  }
}
