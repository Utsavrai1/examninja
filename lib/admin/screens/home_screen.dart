import 'package:examninja/admin/navbar/admin_navbar.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AdminCustomNavbar(),
      body: Column(
        children: [],
      ),
    );
  }
}
