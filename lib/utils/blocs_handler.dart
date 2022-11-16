import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../cubits/theme/theme_cubit.dart';
import '../cubits/weather/weather_cubit.dart';
import '../cubits/temp_settings/temp_settings_cubit.dart';
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
    BlocProvider<WeatherCubit>(
      create: (ctx) => WeatherCubit(
        weatherRepository: ctx.read<WeatherRepository>(),
      ),
    ),
    BlocProvider<TempSettingsCubit>(
      create: (ctx) => TempSettingsCubit(),
    ),
    BlocProvider<ThemeCubit>(
      create: (ctx) => ThemeCubit(),
    ),
  ];
}
