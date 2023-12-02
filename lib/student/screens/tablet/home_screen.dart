import 'package:examninja/student/navbar/student_navbar.dart';
import 'package:examninja/student/screens/bloc/get_exam_bloc.dart';
import 'package:examninja/teacher/model/exam_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:html';

void goFullScreen() {
  document.documentElement?.requestFullscreen();
}

class TabletStudentHomeScreen extends StatelessWidget {
  const TabletStudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const StudentCustomNavbar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: size.width * (0.6),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: BlocBuilder<GetExamBloc, GetExamState>(
              builder: (context, state) {
                if (state is FetchExamState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FetchingExamSuccessState) {
                  return (state.liveExams.isEmpty && state.expiredExams.isEmpty)
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text('No Exams Added'),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.liveExams.isEmpty
                                ? Container()
                                : const SizedBox(
                                    height: 10,
                                  ),
                            state.liveExams.isEmpty
                                ? Container()
                                : const Text(
                                    'Live Exam',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            state.liveExams.isEmpty
                                ? Container()
                                : const SizedBox(
                                    height: 10,
                                  ),
                            state.liveExams.isEmpty
                                ? Container()
                                : SizedBox(
                                    child: ListView.builder(
                                      itemCount: state.liveExams.length,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return testCard(context, index,
                                            state.liveExams[index], true);
                                      },
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            state.expiredExams.isEmpty
                                ? Container()
                                : const Text(
                                    'Past Exam',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            state.expiredExams.isEmpty
                                ? Container()
                                : const SizedBox(
                                    height: 10,
                                  ),
                            state.expiredExams.isEmpty
                                ? Container()
                                : SizedBox(
                                    child: ListView.builder(
                                      itemCount: state.expiredExams.length,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return testCard(context, index,
                                            state.expiredExams[index], false);
                                      },
                                    ),
                                  ),
                          ],
                        );
                } else if (state is FetchingExamFailState) {
                  return Center(child: Text(state.error));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget testCard(
      BuildContext context, int index, ExamModel exam, bool isLive) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 250,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              exam.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  exam.subject,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: Text(
                  exam.marks,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: Text(
                  'Faculty Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: Text(
                  exam.teacherName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: Text(
                  'Test Duration',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${exam.duration} min',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              if (isLive) {
                goFullScreen();

                if (context.mounted) {
                  context.pushNamed('TestScreen',
                      extra: {'exam_id': exam.examId, 'marks': exam.marks});
                }
              }
            },
            child: Container(
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Center(
                child: Text(
                  isLive ? "Attempt" : "View Score",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
