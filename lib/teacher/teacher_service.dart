import 'dart:convert';
import 'package:examninja/storage/local_storage.dart';
import 'package:examninja/teacher/model/question_model.dart';
import 'package:http/http.dart' as http;
import 'package:examninja/constant/constant.dart';

class TeacherServices {
  var client = http.Client();
  static String serverUrl = Constant.serverUrl;

  Future<Map<String, dynamic>> addExam(
    String subject,
    int marks,
    int duration,
    String title,
    String endDate,
    String classOfStudent,
  ) async {
    final teacherId = await LocalStorageService().getDataFromStorage('id');

    Uri url = Uri.https(serverUrl, '/api/exam/createExam');
    final body = {
      'subject': subject,
      'marks': marks.toString(),
      'teacher_id': teacherId,
      'duration': duration.toString(),
      'title': title,
      'end_date': endDate,
      'classOfStudent': classOfStudent
    };

    var response = await client.post(url, body: body);

    var json = jsonDecode(response.body);

    return {
      'status_code': response.statusCode,
      ...json,
    };
  }

  Future<Map<String, dynamic>> getExam() async {
    final teacherId = await LocalStorageService().getDataFromStorage('id');

    Uri url = Uri.https(serverUrl, '/api/exam/getExamByTeacherId', {
      'teacher_id': teacherId,
    });

    var response = await client.get(url);

    var json = jsonDecode(response.body);

    return {
      'status_code': response.statusCode,
      ...json,
    };
  }

  Future<Map<String, dynamic>> createQuestion(QuestionModel question) async {
    Uri url = Uri.https(serverUrl, '/api/question/addQuestion');
    final body = {
      'exam_id': question.examId,
      'question': question.question,
      'options': question.options,
      'correctOption': question.correctOption
    };

    var response = await client.post(url, body: body);

    var json = jsonDecode(response.body);

    return {
      'status_code': response.statusCode,
      ...json,
    };
  }

  Future<Map<String, dynamic>> getQuestion(String examId) async {
    Uri url = Uri.https(serverUrl, '/api/question/getQuestion', {
      'exam_id': examId,
    });

    var response = await client.get(url);

    var json = jsonDecode(response.body);

    return {
      'status_code': response.statusCode,
      ...json,
    };
  }

  Future<Map<String, dynamic>> publishExam(String examId) async {
    Uri url = Uri.https(serverUrl, '/api/exam/publishExam', {
      'exam_id': examId,
    });

    var response = await client.get(url);

    var json = jsonDecode(response.body);

    return {
      'status_code': response.statusCode,
      ...json,
    };
  }
}
