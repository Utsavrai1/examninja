import 'package:examninja/student/navbar/student_navbar.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class StudentResultScreen extends StatelessWidget {
  final double marks;
  final int actualMark;

  StudentResultScreen(
      {super.key, required this.marks, required this.actualMark});
  final List<Color> color = [Colors.lightGreenAccent, Colors.green];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const StudentCustomNavbar(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You Secured : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                SimpleCircularProgressBar(
                  size: 125,
                  progressStrokeWidth: 20,
                  maxValue: actualMark.toDouble(),
                  backStrokeWidth: 0,
                  valueNotifier: ValueNotifier(marks),
                  progressColors: color,
                  mergeMode: true,
                  onGetText: (double value) {
                    return Text(
                      '${marks.toInt()}/ ${actualMark.toInt()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
