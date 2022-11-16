part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class SetThemeEvent extends ThemeEvent {
  final double temp;

  const SetThemeEvent({
    required this.temp,
  });

  @override
  List<Object> get props => [temp];
}
