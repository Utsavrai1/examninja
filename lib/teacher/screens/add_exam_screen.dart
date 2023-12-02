import 'package:examninja/teacher/screens/mobile/add_exam_screen.dart';
import 'package:examninja/teacher/screens/web/add_exam_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddExamScreen extends StatelessWidget {
  const AddExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => WebAddExamScreen(),
      tablet: (context) => MobileAddExamScreen(),
      mobile: (context) => MobileAddExamScreen(),
    );
  }
}
