import 'package:http/http.dart' as http;

abstract class Request {
  Future<http.Response> fetchRequest(uri, {args});
  Future<dynamic> getResponse(uri, {args});
}