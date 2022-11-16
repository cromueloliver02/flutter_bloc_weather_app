import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class SettingsPage extends StatelessWidget {
  static const id = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SETTINGS')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: const Text('Temperature Unit'),
          subtitle: const Text('Celsius/Fahrenheit (Default: Celsius)'),
          trailing: BlocSelector<TempSettingsBloc, TempSettingsState, TempUnit>(
            selector: (state) => state.tempUnit,
            builder: (ctx, tempUnit) => Switch(
              value: tempUnit == TempUnit.celsius,
              onChanged: (value) =>
                  ctx.read<TempSettingsBloc>().add(ToggleTempUnitEvent()),
            ),
          ),
        ),
      ),
    );
  }
}
