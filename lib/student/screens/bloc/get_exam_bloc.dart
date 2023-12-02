import 'package:examninja/student/screens/student_services.dart';
import 'package:examninja/teacher/model/exam_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetExamBloc extends Bloc<GetExamEvent, GetExamState> {
  GetExamBloc() : super(InitialState()) {
    on<GetExamEvent>((event, emit) async {
      if (event is FetchingExamEvent) {
        emit(FetchExamState());

        try {
          final response = await StudentServices().getExamByClass();
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
            emit(FetchingExamSuccessState(
                liveExams: liveExams, expiredExams: expiredExams));
          } else {
            emit(FetchingExamFailState(response['error']));
          }
        } catch (e) {
          emit(FetchingExamFailState('$e'));
        }
      }
    });
  }
}

abstract class GetExamEvent {}

abstract class GetExamState {}

class InitialState extends GetExamState {}

class FetchExamState extends GetExamState {}

class FetchingExamEvent extends GetExamEvent {}

class FetchingExamSuccessState extends GetExamState {
  List<ExamModel> liveExams;
  List<ExamModel> expiredExams;
  FetchingExamSuccessState(
      {required this.liveExams, required this.expiredExams});
}

class FetchingExamFailState extends GetExamState {
  String error;

  FetchingExamFailState(this.error);
}
