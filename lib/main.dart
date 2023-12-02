import 'package:examninja/auth/auth_bloc.dart';
import 'package:examninja/config/router_config.dart';
import 'package:examninja/student/screens/bloc/add_answer_bloc.dart';
import 'package:examninja/student/screens/bloc/get_exam_bloc.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(),
          ),
          BlocProvider(
            create: (_) => TeacherBloc(),
          ),
          BlocProvider(
            create: (_) => GetExamBloc(),
          ),
          BlocProvider(
            create: (_) => AddAnswerBloc(),
          )
        ],
        child: MaterialApp.router(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: false,
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown
            },
          ),
          title: 'Exam Ninja',
          themeMode: ThemeMode.light,
          routerConfig: routerConfiguration,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
