import 'package:examninja/teacher/navbar/mobile/teacher_navbar.dart';
import 'package:examninja/teacher/navbar/web/teacher_navbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TeacherCustomNavbar extends StatelessWidget
    implements PreferredSizeWidget {
  const TeacherCustomNavbar({super.key});
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => const WebTeacherCustomNavbar(),
      tablet: (context) => const MobileTeacherCustomNavbar(),
      mobile: (context) => const MobileTeacherCustomNavbar(),
    );
  }
}
