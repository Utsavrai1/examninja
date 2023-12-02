import 'package:examninja/student/navbar/mobile/student_navbar.dart';
import 'package:examninja/student/navbar/web/student_navbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StudentCustomNavbar extends StatelessWidget
    implements PreferredSizeWidget {
  const StudentCustomNavbar({super.key});
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => const WebStudentCustomNavbar(),
      tablet: (context) => const MobileStudentCustomNavbar(),
      mobile: (context) => const MobileStudentCustomNavbar(),
    );
  }
}
