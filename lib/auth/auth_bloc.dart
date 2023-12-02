import 'package:examninja/auth/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examninja/storage/local_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is AttemptingLoginEvent) {
        emit(LoggingInState());

        try {
          final response =
              await AuthService().login(event.email, event.password);
          if (response['status_code'] == 200) {
            await LocalStorageService()
                .setDataToStorage('db_token', response['token']);

            await LocalStorageService()
                .setDataToStorage('id', response['user_id']);

            await LocalStorageService()
                .setDataToStorage('user_type', response['user_type']);

            if (response['user_type'] == 'Student') {
              await LocalStorageService()
                  .setDataToStorage('student_class', response['student_class']);
              print(response['student_class']);
            }

            emit(LoginSuccessState(
              userType: response['user_type'],
            ));
          } else {
            emit(LoginFailState(response['error']));
          }
        } catch (e) {
          emit(LoginFailState('$e'));
        }
      } else if (event is AttemptingSignUpEvent) {
        emit(SignUpState());

        try {
          final response = await AuthService().signUp(
            event.name,
            event.email,
            event.password,
            event.userType,
            event.classOfStudent,
          );
          if (response['status_code'] == 200) {
            await LocalStorageService()
                .setDataToStorage('db_token', response['token']);

            await LocalStorageService()
                .setDataToStorage('id', response['user_id']);

            await LocalStorageService()
                .setDataToStorage('user_type', response['user_type']);

            if (response['user_type'] == 'Student') {
              await LocalStorageService()
                  .setDataToStorage('student_class', response['student_class']);
            }

            emit(SignUpSuccessState(
              userType: response['user_type'],
            ));
          } else {
            emit(SignUpFailState(response['error']));
          }
        } catch (e) {
          emit(SignUpFailState('$e'));
        }
      }
    });
  }
}

abstract class AuthEvent {}

abstract class AuthState {}

class AttemptingLoginEvent extends AuthEvent {
  String email;
  String password;

  AttemptingLoginEvent({required this.email, required this.password});
}

class InitialState extends AuthState {}

class LoggingInState extends AuthState {}

class LoginSuccessState extends AuthState {
  String userType;
  LoginSuccessState({required this.userType});
}

class LoginFailState extends AuthState {
  String error;

  LoginFailState(this.error);
}

class AttemptingSignUpEvent extends AuthEvent {
  String name;
  String email;
  String password;
  String userType;
  String? classOfStudent;

  AttemptingSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
    required this.classOfStudent,
  });
}

class SignUpState extends AuthState {}

class SignUpSuccessState extends AuthState {
  String userType;
  SignUpSuccessState({required this.userType});
}

class SignUpFailState extends AuthState {
  String error;
  SignUpFailState(this.error);
}
