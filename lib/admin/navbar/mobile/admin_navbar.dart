import 'package:examninja/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MobileAdminCustomNavbar extends StatelessWidget
    implements PreferredSizeWidget {
  const MobileAdminCustomNavbar({super.key});
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
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.home_filled,
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
