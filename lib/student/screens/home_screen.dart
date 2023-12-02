import 'package:examninja/student/screens/bloc/get_exam_bloc.dart';
import 'package:examninja/student/screens/mobile/home_screen.dart';
import 'package:examninja/student/screens/web/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) {
        context.read<GetExamBloc>().add(FetchingExamEvent());

        return const WebStudentHomeScreen();
      },
      tablet: (context) {
        context.read<GetExamBloc>().add(FetchingExamEvent());

        return const MobileStudentHomeScreen();
      },
      mobile: (context) {
        context.read<GetExamBloc>().add(FetchingExamEvent());

        return const MobileStudentHomeScreen();
      },
    );
  }
}
