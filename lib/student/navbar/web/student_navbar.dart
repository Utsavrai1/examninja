import 'package:examninja/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WebStudentCustomNavbar extends StatelessWidget
    implements PreferredSizeWidget {
  const WebStudentCustomNavbar({super.key});
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      title: const Padding(
        padding: EdgeInsets.only(left: 100),
        child: Text(
          'Exam Ninja',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            if (context.mounted) {
              context.goNamed('StudentHome');
            }
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await LocalStorageService()
                .deleteDataFromStorage('user_type')
                .then((value) => {context.pushNamed('LogIn')});
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10, right: 50),
            child: Center(
              child: Text(
                'LogOut',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
