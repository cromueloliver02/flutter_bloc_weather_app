import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/utils/custom_http_exception.dart';
import 'package:weather_app/utils/http_error_handler.dart';
import '../models/directory_geocoding.dart';
import '../utils/constants.dart';

class WeatherApiServices {
  final http.Client httpClient;

  WeatherApiServices({
    required this.httpClient,
  });

  Future<DirectoryGeocoding> getDirectGeocoding(String city) async {
    final uri = Uri(
      scheme: 'http',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      final responseBody = jsonDecode(response.body);

      if (responseBody.isEmpty) {
        throw CustomHttpException(message: 'Cannot get the location of $city');
      }

      final directGeocoding = DirectoryGeocoding.fromJson(responseBody);

      return directGeocoding;
    } catch (err) {
      rethrow;
    }
  }
}
