import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../blocs/theme/theme_bloc.dart';
import '../blocs/weather/weather_bloc.dart';
import '../blocs/temp_settings/temp_settings_bloc.dart';
import '../repositories/weather_repository.dart';
import '../services/weather_api_services.dart';

class BlocsHandler {
  final List<RepositoryProvider> repositoryProviders = [
    RepositoryProvider<WeatherRepository>(
      create: (ctx) => WeatherRepository(
        weatherApiServices: WeatherApiServices(
          httpClient: http.Client(),
        ),
      ),
    ),
  ];

  final List<BlocProvider> blocProviders = [
    BlocProvider<WeatherBloc>(
      create: (ctx) => WeatherBloc(
        weatherRepository: ctx.read<WeatherRepository>(),
      ),
    ),
    BlocProvider<TempSettingsBloc>(
      create: (ctx) => TempSettingsBloc(),
    ),
    BlocProvider<ThemeBloc>(
      create: (ctx) => ThemeBloc(),
    ),
  ];
}
