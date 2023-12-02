import 'package:examninja/teacher/screens/mobile/home_screen.dart';
import 'package:examninja/teacher/screens/tablet/home_screen.dart';
import 'package:examninja/teacher/screens/web/home_screen.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) {
        context.read<TeacherBloc>().add(GettingExamEvent());
        return const WebTeacherHomeScreen();
      },
      tablet: (context) {
        context.read<TeacherBloc>().add(GettingExamEvent());
        return const TabletTeacherHomeScreen();
      },
      mobile: (context) {
        context.read<TeacherBloc>().add(GettingExamEvent());
        return const MobileTeacherHomeScreen();
      },
    );
  }
}
