import 'package:examninja/auth/mobile/login_screen.dart';
import 'package:examninja/auth/web/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => const WebLoginScreen(),
      tablet: (context) => const MobileLoginScreen(),
      mobile: (context) => const MobileLoginScreen(),
    );
  }
}
