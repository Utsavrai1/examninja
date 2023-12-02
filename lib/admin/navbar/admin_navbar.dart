import 'package:examninja/admin/navbar/mobile/admin_navbar.dart';
import 'package:examninja/admin/navbar/web/admin_navbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminCustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AdminCustomNavbar({super.key});
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => const WebAdminCustomNavbar(),
      tablet: (context) => const MobileAdminCustomNavbar(),
      mobile: (context) => const MobileAdminCustomNavbar(),
    );
  }
}
