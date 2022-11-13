class CustomHttpException implements Exception {
  String message;

  CustomHttpException({this.message = 'Someting went wrong'}) {
    message = 'Weather Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}
