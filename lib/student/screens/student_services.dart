import 'dart:convert';

import 'package:examninja/constant/constant.dart';
import 'package:examninja/storage/local_storage.dart';
import 'package:http/http.dart' as http;

class StudentServices {
  var client = http.Client();
  static String serverUrl = Constant.serverUrl;

  Future<Map<String, dynamic>> getExamByClass() async {
    final studentClass =
        await LocalStorageService().getDataFromStorage('student_class');

    Uri url = Uri.https(serverUrl, '/api/exam/getExamByClass', {
      'student_class': studentClass,
    });

    var response = await client.get(url);

    var json = jsonDecode(response.body);

    return {
      'status_code': response.statusCode,
      ...json,
    };
  }

  Future<Map<String, dynamic>> addAnswer(String optionId, String answers,
      String questionId, String examId, String score) async {
    final student_id = await LocalStorageService().getDataFromStorage('id');

    Uri url = Uri.https(serverUrl, '/api/exam/addAnswer');

    final body = {
      'optionId': optionId,
      'answers': answers,
      'questionId': questionId,
      'examId': examId,
      'user_id': student_id,
      'score': score,
    };

    var response = await client.post(url, body: body);

    var json = jsonDecode(response.body);

    return {
      'status_code': response.statusCode,
      ...json,
    };
  }
}
