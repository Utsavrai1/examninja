import 'dart:convert';

import 'package:examninja/constant/constant.dart';
import 'package:http/http.dart' as http;

class AuthService {
  var client = http.Client();
  static String serverUrl = Constant.serverUrl;

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    Uri url = Uri.https(serverUrl, '/api/auth/logIn');

    final body = {
      'email': email,
      'password': password,
    };

    var response = await client.post(url, body: body);

    var json = jsonDecode(response.body);

    return {
      'status_code': response.statusCode,
      ...json,
    };
  }

  Future<Map> signUp(
    String name,
    String email,
    String password,
    String userType,
    String? classOfStudent,
  ) async {
    Uri url = Uri.https(serverUrl, '/api/auth/signup');

    final body = {
      'name': name,
      'email': email,
      'password': password,
      'user_type': userType,
      'studentclass': classOfStudent.toString(),
    };

    var response = await client.post(url, body: body);

    var json = jsonDecode(response.body);

    return {
      'status_code': response.statusCode,
      ...json,
    };
  }
}
