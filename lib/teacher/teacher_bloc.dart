import 'package:examninja/teacher/model/exam_model.dart';
import 'package:examninja/teacher/model/question_model.dart';
import 'package:examninja/teacher/teacher_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherBloc() : super(InitialState()) {
    on<TeacherEvent>((event, emit) async {
      if (event is AttemptingExamCreatingEvent) {
        emit(CreateExamState());

        try {
          final response = await TeacherServices().addExam(
            event.subject,
            event.marks,
            event.duration,
            event.title,
            event.endDate,
            event.classOfStudent,
          );
          if (response['status_code'] == 200) {
            emit(ExamCreatedSuccessState());
          } else {
            emit(ExamCreatedFailState(response['error']));
          }
        } catch (e) {
          emit(ExamCreatedFailState('$e'));
        }
      } else if (event is GettingExamEvent) {
        emit(GetExamState());
        try {
          final response = await TeacherServices().getExam();
          if (response['status_code'] == 200) {
            List<ExamModel> liveExams = [];

            List<ExamModel> expiredExams = [];

            final DateTime currentDate = DateTime.now();
            for (var examJson in response['data']) {
              ExamModel exam = ExamModel.fromJson(examJson);
              if (currentDate.isAfter(exam.endDate)) {
                expiredExams.add(exam);
              } else {
                liveExams.add(exam);
              }
            }

            emit(GettingExamSuccessState(
                liveExams: liveExams, expiredExams: expiredExams));
          } else {
            emit(GettingExamFailState(response['error']));
          }
        } catch (e) {
          emit(GettingExamFailState('$e'));
        }
      } else if (event is AddingQuestionEvent) {
        emit(CreateQuestionState());

        try {
          final response = await TeacherServices().createQuestion(
            event.question,
          );
          if (response['status_code'] == 200) {
            emit(QuestionCreatedSuccessState());
          } else {
            emit(QuestionCreatedFailState(response['error']));
          }
        } catch (e) {
          emit(QuestionCreatedFailState('$e'));
        }
      } else if (event is GettingQuestionEvent) {
        emit(GetQuestionState());
        try {
          final response = await TeacherServices().getQuestion(event.examId);
          if (response['status_code'] == 200) {
            List examData = response['data'];
            int index = 0, j = 0;
            print(response);
            // Separate questions and options

            List<String> questions = [];
            List<String> questionsId = [];
            for (var questionData in examData) {
              String questionText = questionData['question_text'];
              String questionId = questionData['question_id'];
              questions.add(questionText);
              questionsId.add(questionId);
            }

            questions = questions.toSet().toList();

            List<List<Map<String, dynamic>>> options =
                List.generate(questions.length, (index) => []);
            List<String> correctAnswers = [];
            for (var questionData in examData) {
              options[index].add({
                'option_text': questionData['option_text'],
                'option_id': questionData['option_id']
              });
              if (questionData['is_correct'].toString() == 'true') {
                correctAnswers.add(questionData['option_text']);
              }
              if (j == 3) {
                j = 0;
                index++;
              } else {
                j++;
              }
            }

            List<String> answers =
                List.generate(questions.length, (index) => '');
            List<String> answerOptionId =
                List.generate(questions.length, (index) => '');
            emit(GettingQuestionSuccessState(
              questions: questions,
              options: options,
              answers: answers,
              questionId: questionsId,
              correctAnswer: correctAnswers,
              answerOptionId: answerOptionId,
            ));
          } else {
            emit(GettingQuestionFailState(response['error']));
          }
        } catch (e) {
          emit(GettingQuestionFailState('$e'));
        }
      } else if (event is PublishExamEvent) {
        emit(PublishExamState());
        try {
          final response = await TeacherServices().publishExam(event.examId);
          if (response['status_code'] == 200) {
            emit(PublishingExamSuccessState());
          } else {
            emit(PublishingExamFailState(response['error']));
          }
        } catch (e) {
          emit(PublishingExamFailState('$e'));
        }
      }
    });
  }
}

abstract class TeacherEvent {}

abstract class TeacherState {}

class AttemptingExamCreatingEvent extends TeacherEvent {
  String subject;
  int marks;
  int duration;
  String title;
  String endDate;
  String classOfStudent;

  AttemptingExamCreatingEvent({
    required this.subject,
    required this.marks,
    required this.duration,
    required this.title,
    required this.endDate,
    required this.classOfStudent,
  });
}

class InitialState extends TeacherState {}

class CreateExamState extends TeacherState {}

class ExamCreatedSuccessState extends TeacherState {}

class ExamCreatedFailState extends TeacherState {
  String error;

  ExamCreatedFailState(this.error);
}

class GettingExamEvent extends TeacherEvent {}

class GetExamState extends TeacherState {}

class GettingExamSuccessState extends TeacherState {
  List<ExamModel> liveExams;
  List<ExamModel> expiredExams;
  GettingExamSuccessState(
      {required this.liveExams, required this.expiredExams});
}

class GettingExamFailState extends TeacherState {
  String error;
  GettingExamFailState(this.error);
}

class AddingQuestionEvent extends TeacherEvent {
  QuestionModel question;
  AddingQuestionEvent({required this.question});
}

class CreateQuestionState extends TeacherState {}

class QuestionCreatedSuccessState extends TeacherState {}

class QuestionCreatedFailState extends TeacherState {
  String error;
  QuestionCreatedFailState(this.error);
}

class GettingQuestionEvent extends TeacherEvent {
  String examId;
  GettingQuestionEvent({required this.examId});
}

class GetQuestionState extends TeacherState {}

class GettingQuestionSuccessState extends TeacherState {
  List questions;
  List<List> options;
  List<String> answers;
  List<String> questionId;
  List<String> correctAnswer;
  List<String> answerOptionId;
  GettingQuestionSuccessState({
    required this.questions,
    required this.options,
    required this.answers,
    required this.questionId,
    required this.correctAnswer,
    required this.answerOptionId,
  });
}

class GettingQuestionFailState extends TeacherState {
  String error;
  GettingQuestionFailState(this.error);
}

class PublishExamEvent extends TeacherEvent {
  String examId;
  PublishExamEvent({required this.examId});
}

class PublishExamState extends TeacherState {}

class PublishingExamSuccessState extends TeacherState {
  PublishingExamSuccessState();
}

class PublishingExamFailState extends TeacherState {
  String error;
  PublishingExamFailState(this.error);
}
