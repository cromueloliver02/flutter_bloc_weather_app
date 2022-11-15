import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/pages.dart';

import '../cubits/weather/weather_cubit.dart';

class HomePage extends StatefulWidget {
  static const id = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _goToSearchPage() async {
    final weatherCubit = context.read<WeatherCubit>();
    final city = await Navigator.pushNamed(context, SearchPage.id) as String?;

    if (city != null) {
      await weatherCubit.fetchWeather(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        actions: [
          IconButton(
            onPressed: _goToSearchPage,
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
      ),
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (ctx, state) {
          if (state.status == WeatherStatus.error) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                content: Text(state.error.errMsg),
              ),
            );
          }
        },
        builder: (ctx, state) {
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

          if (state.status == WeatherStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Text(
              state.weather.temp.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
