import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../blocs/weather/weather_bloc.dart';
import '../../utils/constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  late final StreamSubscription _weatherSubscription;
  final WeatherBloc weatherBloc;

  ThemeBloc({
    required this.weatherBloc,
  }) : super(ThemeState.initial()) {
    _weatherSubscription = weatherBloc.stream.listen(
      (state) => add(SetThemeEvent(temp: state.weather.temp)),
    );

    on<SetThemeEvent>(_setTheme);
  }

  @override
  Future<void> close() {
    _weatherSubscription.cancel();
    return super.close();
  }

  void _setTheme(SetThemeEvent event, Emitter<ThemeState> emit) {
    if (kDebugMode) print('temp ${event.temp}');

    if (event.temp > kWarmOrNot) {
      emit(state.copyWith(appTheme: AppTheme.light));
    } else {
      emit(state.copyWith(appTheme: AppTheme.dark));
    }
  }
}
