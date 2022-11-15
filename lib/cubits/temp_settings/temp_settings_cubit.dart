// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_state.dart';

class TempSettingsCubit extends Cubit<TempSettingsState> {
  TempSettingsCubit() : super(TempSettingsState.initial());

  void toggleTempUnit() {
    final tempUnit = state.tempUnit == TempUnit.celsius
        ? TempUnit.fahrenheit
        : TempUnit.celsius;

    emit(state.copyWith(tempUnit: tempUnit));
  }
}
