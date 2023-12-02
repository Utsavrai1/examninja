import 'package:examninja/student/screens/student_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAnswerBloc extends Bloc<AddAnswerEvent, AddAnswerState> {
  AddAnswerBloc() : super(InitialState()) {
    on<AddAnswerEvent>((event, emit) async {
      if (event is AddingAnswerEvent) {
        emit(AddingAnswerState());

        try {
          final response = await StudentServices().addAnswer(
            event.optionId,
            event.answers,
            event.questionId,
            event.examId,
            event.score,
          );
          if (response['status_code'] == 200) {
            emit(AddingAnswerSuccessState());
          } else {
            emit(AddingAnswerFailState(response['error']));
          }
        } catch (e) {
          emit(AddingAnswerFailState('$e'));
        }
      }
    });
  }
}

abstract class AddAnswerEvent {}

abstract class AddAnswerState {}

class InitialState extends AddAnswerState {}

class AddingAnswerState extends AddAnswerState {}

class AddingAnswerEvent extends AddAnswerEvent {
  String optionId;
  String answers;
  String questionId;
  String examId;
  String score;

  AddingAnswerEvent(
      {required this.optionId,
      required this.answers,
      required this.questionId,
      required this.examId,
      required this.score});
}

class AddingAnswerSuccessState extends AddAnswerState {}

class AddingAnswerFailState extends AddAnswerState {
  String error;

  AddingAnswerFailState(this.error);
}
