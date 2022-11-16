import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../cubits/weather/weather_cubit.dart';
import '../../utils/constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late final StreamSubscription weatherSubscription;
  final WeatherCubit weatherCubit;

  ThemeCubit({
    required this.weatherCubit,
  }) : super(ThemeState.initial()) {
    weatherSubscription = weatherCubit.stream.listen(_weatherListener);
  }

  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }

  void _weatherListener(WeatherState weatherState) {
    if (kDebugMode) print('tempss ${weatherState.weather.temp}');

    if (weatherState.weather.temp > kWarmOrNot) {
      emit(state.copyWith(appTheme: AppTheme.light));
    } else {
      emit(state.copyWith(appTheme: AppTheme.dark));
    }
  }
}
