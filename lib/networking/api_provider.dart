import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import 'custom_exceptions.dart';

class ApiProvider {
  final String _baseUrl='api.denzo.io';
  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${UserData().userModel.token ?? ''}'
  };

  Future<dynamic> getData(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.https(_baseUrl, url, queryParameters),
        headers: _headers,
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    dynamic responseJson;
    try {
      // print(queryParameters);
      final response = await http.post(
        Uri.https(_baseUrl, url, queryParameters),
        headers: _headers,
        body: formData,
      );
      responseJson = _response(response);
      // debugPrint(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> multipart(
    String url, {
    required Map data,
    required List<String> files,
  }) async {
    final uri = Uri.https(_baseUrl, url);
    final request = http.MultipartRequest('POST', uri);

    request.headers.addAll(_headers);

    data.forEach((k, v) {
      bool validateValues = files.any((element) => element == k);
      if (!validateValues) request.fields[k] = data[k];
    });

    data.forEach((k, v) async {
      bool validateValues = files.any((element) => element == k.toString());

      if (validateValues) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath(k, data[k]);

        request.files.add(multipartFile);
      }
    });

    bool status = false;
    try {
      http.StreamedResponse res = await request.send();

      if (res.statusCode == 200) {
        var response = await http.Response.fromStream(res);
        var responseJson = json.decode(response.body.toString());

        if (responseJson['status'] ?? 200) {
          return responseJson;
        } else {
          throw Exception(responseJson['message']);
        }
      } else {
        var response = await http.Response.fromStream(res);
        final responseJson = json.decode(response.body.toString());

        throwException(responseJson);
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return status;
  }

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    dynamic responseJson;
    try {
      debugPrint(queryParameters.toString());
      final response = await http.delete(
        Uri.https(_baseUrl, url, queryParameters),
        headers: _headers,
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postJson(String url, Map<dynamic, dynamic> data) async {
    dynamic responseJson;

    try {
      final response = await http.post(
        Uri.http(_baseUrl, url),
        headers: _headers,
        body: json.encode(data),
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body.toString());
      // print(responseJson);
      if (responseJson['status'] == 200) {
        return responseJson;
      } else {
        throwException(responseJson);
        // throw Exception(responseJson['message']);
      }
    } else {
      final responseJson = json.decode(response.body.toString());
      // print(responseJson);
      throwException(responseJson);
    }
  }
}

void throwException(Map<String, dynamic> data) {
  if (data.containsKey('data')) {
    List message = [];

    if (data['data'].runtimeType.toString().contains('Map')) {
      data['data'].forEach(
        (key, value) {
          if (value.runtimeType.toString().contains('List')) {
            value.forEach((e) => message.add(e));
          } else {
            message.add(value);
          }
        },
      );
    } else {
      message.add(data['message']);
    }

    throw Exception(message.join('\n'));
  } else if (data.containsKey('message')) {
    throw Exception(data['message']);
  } else {
    throw Exception('Error');
  }
}
