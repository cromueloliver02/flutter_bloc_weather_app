import 'package:http/http.dart' as http;

String httpErrorMessageHandler(http.Response response) {
  final statusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;

  final errorMessage =
      'Request failedsssss\nStatus Code: $statusCode\nReason: $reasonPhrase';

  return errorMessage;
}
