import 'dart:convert';
import 'package:pokegendra/constants/constants.dart';
import 'package:pokegendra/data/HttpResponse.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<HttpResponse> get<T>(path,
      {Map<String, String>? params, String token = ""}) async {
    try {
      Uri uri = buildUri(path, params: params);
      Map<String, String> headers = {"Authorization": "Bearer " + token};
      http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode >= 200 || response.statusCode <= 300) {
        T data = jsonDecode(response.body);
        return HttpResponse.success(data, response.statusCode);
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        return HttpResponse.fail(
            statusCode: 500, message: 'Internal server error', data: data);
      }
    } catch (e) {
      return HttpResponse.fail(
        statusCode: -1,
        message: 'Desconocido',
        data: null,
      );
    }
  }

  Future<HttpResponse> post<T>(
    String path, {
    Map<String, String>? params,
    Map<String, String>? body,
    String token = "",
    String? jsonBody,
    bool jsonE = false,
  }) async {
    try {
      Uri uri = buildUri(path, params: params);
      Map<String, String> headers = {
        "Authorization": "Bearer " + token,
      };
      Map<String, String> jsonHeaders = {
        "Authorization": "Bearer " + token,
        'Content-type': 'application/json'
      };
      http.Response response = await http.post(
        uri,
        body: jsonE ? jsonBody : body,
        headers: jsonE ? jsonHeaders : headers,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        T data = jsonDecode(response.body);
        return HttpResponse.success(data, response.statusCode);
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        return HttpResponse.fail(
          statusCode: response.statusCode,
          message: '',
          data: data,
        );
      }
    } catch (e) {
      return HttpResponse.fail(
        statusCode: -1,
        message: 'Desconocido',
        data: null,
      );
    }
  }

  Uri buildUri(String path, {Map<String, String>? params}) {
    Uri baseUri = Uri.parse(urlApi);
    if (baseUri.scheme == 'http') {
      return Uri.http(baseUri.host, path, params);
    } else {
      return Uri.https(baseUri.host, path, params);
    }
  }
}
