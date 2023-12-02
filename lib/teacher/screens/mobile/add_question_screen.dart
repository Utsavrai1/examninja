import 'package:examninja/teacher/navbar/teacher_navbar.dart';
import 'package:examninja/teacher/screens/alertdialog/alert_dialog_box.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddQuestionMobileScreen extends StatelessWidget {
  final String examId;
  AddQuestionMobileScreen({super.key, required this.examId});

  final ValueNotifier<bool> isLoaded = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hasQuestion = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const TeacherCustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
              valueListenable: isLoaded,
              builder: (context, value, child) => Visibility(
                visible: value,
                child: GestureDetector(
                  onTap: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Builder(
                          builder: (context) {
                            return AddQuestionAlertDialogBox(
                              examId: examId,
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    width: 150,
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            "Add Question",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<TeacherBloc, TeacherState>(
              builder: (context, state) {
                if (state is GetQuestionState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GettingQuestionSuccessState) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    isLoaded.value = true;
                    if (state.questions.isNotEmpty) {
                      hasQuestion.value = true;
                    }
                  });
                  if (state.questions.isNotEmpty) {
                    return Center(
                      child: Container(
                        color: Colors.transparent,
                        width: size.width * (0.8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.questions.length,
                          itemBuilder: (context, i) => Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: size.width * (0.5),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    '${i + 1}. ${state.questions[i]}',
                                    style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 4,
                                  itemBuilder: (context, j) => Container(
                                    width: size.width * (0.4),
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 10,
                                      right: 10,
                                      bottom: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "${j + 1}. ${state.options[i][j]['option_text']}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No Questions Added Yet',
                      ),
                    );
                  }
                } else if (state is GettingQuestionFailState) {
                  return Center(child: Text(state.error));
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
              valueListenable: hasQuestion,
              builder: (context, value, child) => Visibility(
                visible: value,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    width: 150,
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload,
                            color: Colors.white,
                          ),
                          Text(
                            "Publish Exam",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
