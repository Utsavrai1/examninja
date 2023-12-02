import 'package:examninja/admin/screens/home_screen.dart';
import 'package:examninja/auth/login_screen.dart';
import 'package:examninja/auth/sign_up_screen.dart';
import 'package:examninja/student/screens/bloc/get_exam_bloc.dart';
import 'package:examninja/student/screens/home_screen.dart';
import 'package:examninja/student/screens/result_screen.dart';
import 'package:examninja/student/screens/test_screen.dart';
import 'package:examninja/teacher/screens/add_exam_screen.dart';
import 'package:examninja/teacher/screens/add_question_screen.dart';
import 'package:examninja/teacher/screens/home_screen.dart';
import 'package:examninja/teacher/screens/see_question_screen.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:examninja/storage/local_storage.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
bool redirected = false;

final routerConfiguration = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/admin_home',
  redirect: (value, state) async {
    if (redirected) {
      return null;
    }

    final userType =
        await LocalStorageService().getDataFromStorage('user_type');
    if (userType == null) {
      return '/login';
    } else if (userType == 'Admin') {
      redirected = true;
      return '/admin_home';
    } else if (userType == 'Student') {
      redirected = true;
      return '/student_home';
    } else if (userType == 'Teacher') {
      redirected = true;
      return '/teacher_home';
    }
    return null;
  },
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'LogIn',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'SignUp',
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'AdminHome',
      path: '/admin_home',
      builder: (context, state) => const AdminHomeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'TeacherHome',
      path: '/teacher_home',
      builder: (context, state) {
        context.read<TeacherBloc>().add(GettingExamEvent());
        return const TeacherHomeScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'AddExam',
      path: '/add_exam',
      builder: (context, state) {
        return const AddExamScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'StudentHome',
      path: '/student_home',
      builder: (context, state) {
        context.read<GetExamBloc>().add(FetchingExamEvent());

        return const StudentHomeScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'TestScreen',
      path: '/test_screen',
      builder: (context, state) {
        Map examData = state.extra as Map;
        String examId = examData['exam_id'];
        String marks = examData['marks'];
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));

        return StudentTestScreen(examId: examId, marks: marks);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'AddQuestion',
      path: '/add_question',
      builder: (context, state) {
        String examId = state.extra as String;
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));

        return AddQuestionScreen(
          examId: examId,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'SeeQuestion',
      path: '/see_question',
      builder: (context, state) {
        String examId = state.extra as String;
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));

        return SeeQuestionScreen(
          examId: examId,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'Result',
      path: '/result',
      builder: (context, state) {
        Map marks = state.extra as Map;
        final securedMark = marks['securedMarks'];
        final actualMark = marks['actualMarks'];
        return StudentResultScreen(marks: securedMark, actualMark: actualMark);
      },
    ),
  ],
  debugLogDiagnostics: true,
);
