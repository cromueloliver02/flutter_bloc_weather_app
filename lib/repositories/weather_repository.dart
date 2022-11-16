import '../models/direct_geocoding.dart';
import '../models/weather.dart';
import '../models/custom_error.dart';
import '../services/weather_api_services.dart';
import '../utils/weather_exception.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;

  WeatherRepository({required this.weatherApiServices});

  Future<Weather> fetchWeather(String city) async {
    try {
      final directGeocodingJson =
          await weatherApiServices.getDirectGeocoding(city);
      final DirectGeocoding directGeocoding =
          DirectGeocoding.fromJson(directGeocodingJson);

      final tempWeatherJson =
          await weatherApiServices.getWeather(directGeocoding);
      final Weather temporaryWeather = Weather.fromJson(tempWeatherJson);

      final Weather weather = temporaryWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      return weather;
    } on WeatherException catch (err) {
      throw CustomError(errMsg: err.message);
    } catch (err) {
      throw CustomError(errMsg: err.toString());
    }
  }
}
