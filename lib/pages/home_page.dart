import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

import '../blocs/blocs.dart';
import '../pages/pages.dart';
import '../utils/functions.dart';
import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  static const id = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _goToSearchPage() async {
    final weatherBloc = context.read<WeatherBloc>();
    final city = await Navigator.pushNamed(context, SearchPage.id) as String?;

    if (city != null) {
      weatherBloc.add(FetchWeatherEvent(city: city));
    }
  }

  void _goToSettingsPage() => Navigator.pushNamed(context, SettingsPage.id);

  void _weatherListener(BuildContext ctx, WeatherState state) {
    if (state.status == WeatherStatus.error) {
      showErrorDialog(ctx, state.error.errMsg);
    }
  }

  String _showTemperature(double temp) {
    final tempUnit = context.watch<TempSettingsBloc>().state.tempUnit;

    if (tempUnit == TempUnit.celsius) return '${temp.toStringAsFixed(2)} ℃';

    return '${((temp * 9 / 5) + 32).toStringAsFixed(2)} ℉';
  }

  Widget _showIcon(String icon) => FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        image: 'http://$kIconHost/img/wn/$icon@4x.png',
        width: 96,
        height: 96,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('HOME'),
        actions: [
          IconButton(
            onPressed: _goToSearchPage,
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: _goToSettingsPage,
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: _weatherListener,
        builder: (ctx, state) {
          if (state.status == WeatherStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == WeatherStatus.initial ||
              state.status == WeatherStatus.error ||
              state.weather.name.isEmpty) {
            return const Center(
              child: Text(
                'Select a city',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Text(
                state.weather.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    TimeOfDay.fromDateTime(state.weather.lastUpdated)
                        .format(context),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '(${state.weather.country})',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _showTemperature(state.weather.temp),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Text(
                        _showTemperature(state.weather.tempMax),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _showTemperature(state.weather.tempMin),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(),
                  _showIcon(state.weather.icon),
                  Expanded(
                    child: Text(
                      state.weather.description.titleCase,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
