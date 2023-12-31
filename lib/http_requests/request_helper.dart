import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

String baseUrl = 'https://devapi.opticash.io/api/v1/';

enum RequestType { get, post }

class HttpRequestHelper {
  static Future<Map<String, dynamic>> makeRequest({
    required String path,
    required RequestType requestType,
    int timeOutDurationInSeconds = 45,
    String? body,
  }) async {
    String url = '$baseUrl$path';
    http.Response response;

    try {
      switch (requestType) {
        case RequestType.get:
          response = await http.get(Uri.parse(url), headers: {
            'Accept': 'application/json',
          }).timeout(
            Duration(seconds: timeOutDurationInSeconds),
          );
          break;

        default:
          response = await http.post(Uri.parse(url), body: body, headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          }).timeout(
            Duration(seconds: timeOutDurationInSeconds),
          );
          break;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'status': true, 'data': jsonDecode(response.body)['data']};
      }

      return {'status': false, 'data': jsonDecode(response.body)};
    } on SocketException catch (_) {
      return {
        'status': false,
        'data': {'message': 'No internet connection'}
      };
    } catch (e) {
      return {
        'status': false,
        'data': {'message': 'An error occurred. Try again.'}
      };
    }
  }
}
