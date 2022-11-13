import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/direct_geocoding.dart';
import '../utils/http_error_handler.dart';
import '../utils/weather_exception.dart';
import '../utils/constants.dart';

class WeatherApiServices {
  final http.Client httpClient;

  WeatherApiServices({
    required this.httpClient,
  });

  Future<String> getDirectGeocoding(String city) async {
    final uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = jsonDecode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException(message: 'Cannot get the location of $city');
      }

      final directGeocodingJson = response.body;

      return directGeocodingJson;
    } catch (err) {
      rethrow;
    }
  }

  Future<String> getWeather(DirectGeocoding directGeocoding) async {
    final uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.lat}',
        'lon': '${directGeocoding.lon}',
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = response.body;

      return weatherJson;
    } catch (err) {
      rethrow;
    }
  }
}
