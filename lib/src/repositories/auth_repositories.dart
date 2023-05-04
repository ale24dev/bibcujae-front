// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../resources/urls.dart';
import '../shared/repository/ApiResult.dart';

class AuthRepository {
  Future<ApiResult> login(String username, String password) async {
    ApiResult result = ApiResult();
    try {
      Map<String, dynamic> map = {
        "username": username,
        "password": password,
      };
      Uri targetUrl = Uri.parse(Urls.login);
      var response = await http.post(
        targetUrl,
        body: jsonEncode(map),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      var jsonDecode = json.decode(utf8.decode(response.bodyBytes));
      result.responseObject = jsonDecode["error"];
      result.statusCode = response.statusCode;
    } catch (e) {
      print("EROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR 1" + e.toString());
      result.serverError = e.toString();
    }
    return result;
  }
}
