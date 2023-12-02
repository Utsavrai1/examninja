import 'package:examninja/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MobileTeacherCustomNavbar extends StatelessWidget
    implements PreferredSizeWidget {
  const MobileTeacherCustomNavbar({super.key});
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
          onTap: () {
            if (context.mounted) {
              context.goNamed('TeacherHome');
            }
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Icon(
              Icons.home_filled,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed('AddExam');
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Icon(
              Icons.add,
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
            child: Icon(
              Icons.logout,
            ),
          ),
        ),
      ],
    );
  }
}
