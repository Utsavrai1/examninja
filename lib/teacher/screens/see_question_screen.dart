import 'package:examninja/teacher/screens/mobile/see_question_screen.dart';
import 'package:examninja/teacher/screens/web/see_question_screen.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeeQuestionScreen extends StatelessWidget {
  final String examId;
  const SeeQuestionScreen({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) {
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));
        return SeeQuestionWebScreen(
          examId: examId,
        );
      },
      tablet: (context) {
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));

        return SeeQuestionMobileScreen(examId: examId);
      },
      mobile: (context) {
        context.read<TeacherBloc>().add(GettingQuestionEvent(examId: examId));

        return SeeQuestionMobileScreen(examId: examId);
      },
    );
  }
}
