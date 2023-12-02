import 'package:examninja/teacher/model/exam_model.dart';
import 'package:examninja/teacher/navbar/teacher_navbar.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WebTeacherHomeScreen extends StatelessWidget {
  const WebTeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TeacherCustomNavbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BlocBuilder<TeacherBloc, TeacherState>(
            builder: (context, state) {
              if (state is GetExamState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GettingExamSuccessState) {
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
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: state.liveExams.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
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
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: state.expiredExams.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return testCard(context, index,
                                          state.expiredExams[index], false);
                                    },
                                  ),
                                ),
                        ],
                      );
              } else if (state is GettingExamFailState) {
                return Center(child: Text(state.error));
              } else {
                return const SizedBox();
              }
            },
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
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isLive
                      ? (exam.isLive ? Colors.green : Colors.blue.shade600)
                      : Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    isLive
                        ? (exam.isLive ? 'Published' : 'Un-Published')
                        : ('Ended'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                if (!exam.isLive) {
                  if (context.mounted) {
                    context.pushNamed('AddQuestion', extra: exam.examId);
                  }
                } else {
                  if (context.mounted) {
                    context.pushNamed('SeeQuestion', extra: exam.examId);
                  }
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
                  isLive
                      ? (exam.isLive ? "View" : "Add Question")
                      : "View Score",
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
