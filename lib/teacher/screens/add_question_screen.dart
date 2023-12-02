import 'package:examninja/teacher/screens/mobile/add_question_screen.dart';
import 'package:examninja/teacher/screens/web/add_question_screen.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddQuestionScreen extends StatelessWidget {
  final String examId;
  const AddQuestionScreen({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) {
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));
        return AddQuestionWebScreen(
          examId: examId,
        );
      },
      tablet: (context) {
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));

        return AddQuestionMobileScreen(examId: examId);
      },
      mobile: (context) {
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));

        return AddQuestionMobileScreen(examId: examId);
      },
    );
  }
}
