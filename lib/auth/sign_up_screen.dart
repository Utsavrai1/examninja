import 'package:examninja/auth/mobile/sign_up_screen.dart';
import 'package:examninja/auth/web/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => const WebSignUpScreen(),
      tablet: (context) => const MobileSignUpScreen(),
      mobile: (context) => const MobileSignUpScreen(),
    );
  }
}
