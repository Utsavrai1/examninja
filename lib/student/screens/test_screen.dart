import 'package:examninja/student/screens/mobile/test_screen.dart';
import 'package:examninja/student/screens/web/test_screen.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StudentTestScreen extends StatelessWidget {
  final String examId;
  final String marks;
  const StudentTestScreen(
      {super.key, required this.examId, required this.marks});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) {
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));

        return WebStudentTestScreen(
          examId: examId,
          marks: marks,
        );
      },
      tablet: (context) {
        context.read<TeacherBloc>().add(GettingQuestionEvent(
              examId: examId,
            ));

        return MobileStudentTestScreen(
          examId: examId,
          marks: marks,
        );
      },
      mobile: (context) {
        context.read<TeacherBloc>().add(GettingQuestionEvent(
              examId: examId,
            ));

        return MobileStudentTestScreen(
          examId: examId,
          marks: marks,
        );
      },
    );
  }
}
