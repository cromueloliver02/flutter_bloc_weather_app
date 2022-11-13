class WeatherException implements Exception {
  String message;

  WeatherException({this.message = 'Someting went wrong'}) {
    message = 'Weather Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}
