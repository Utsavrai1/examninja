import 'package:examninja/student/navbar/student_navbar.dart';
import 'package:examninja/student/screens/bloc/add_answer_bloc.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MobileStudentTestScreen extends StatefulWidget {
  final String examId;
  final String marks;
  const MobileStudentTestScreen(
      {super.key, required this.examId, required this.marks});

  @override
  State<MobileStudentTestScreen> createState() =>
      _MobileStudentTestScreenState();
}

class _MobileStudentTestScreenState extends State<MobileStudentTestScreen> {
  double calculateMarks(List answer, List markedAnswer, int marks) {
    int correctAnswer = 0;
    int totalQuestion = answer.length;
    for (int i = 0; i < answer.length; i++) {
      if (answer[i] == markedAnswer[i]) {
        correctAnswer++;
      }
    }

    double totalMarks = marks * (correctAnswer / totalQuestion);

    return totalMarks;
  }

  final ValueNotifier<bool> isLoaded = ValueNotifier<bool>(false);

  final ValueNotifier<bool> hasQuestion = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const StudentCustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    return Column(
                      children: [
                        Center(
                          child: Container(
                            color: Colors.transparent,
                            width: size.width * (0.5),
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
                                      itemBuilder: (context, j) {
                                        String optionText =
                                            state.options[i][j]['option_text'];
                                        // const optionText = state.options[i][j]['option_text'];
                                        return GestureDetector(
                                          onTap: () {
                                            if (mounted) {
                                              setState(() {
                                                state.answers[i] =
                                                    state.options[i][j]
                                                        ['option_text'];
                                                state.answerOptionId[i] = state
                                                    .options[i][j]['option_id'];
                                              });
                                            }
                                          },
                                          child: state.answers[i] ==
                                                  state.options[i][j]
                                                      ['option_text']
                                              ? Container(
                                                  width: size.width * (0.4),
                                                  margin: const EdgeInsets.only(
                                                      left: 20, top: 10),
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 5,
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    "${j + 1}. $optionText",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              : Container(
                                                  width: size.width * (0.4),
                                                  margin: const EdgeInsets.only(
                                                      left: 20, top: 10),
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 5,
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    '${j + 1}. $optionText',
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            double securedMarks = calculateMarks(
                                state.correctAnswer,
                                state.answers,
                                int.parse(widget.marks));
                            context.read<AddAnswerBloc>().add(
                                  AddingAnswerEvent(
                                    optionId: state.answerOptionId.join(','),
                                    answers: state.answers.join(','),
                                    questionId: state.questionId.join(','),
                                    examId: widget.examId,
                                    score: securedMarks.toInt().toString(),
                                  ),
                                );

                            showDialog(
                              context: context,
                              builder: (_) {
                                return BlocConsumer<AddAnswerBloc,
                                    AddAnswerState>(
                                  listener: (context, state) async {
                                    if (state is AddingAnswerSuccessState) {
                                      context.pushNamed('Result', extra: {
                                        'securedMarks': securedMarks,
                                        'actualMarks': int.parse(widget.marks)
                                      });
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AddingAnswerSuccessState) {
                                      return AlertDialog(
                                        title: const Text('Success!'),
                                        content: const Text(
                                            'Answer Added successfully'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => context.pop(),
                                            child: const Text('Great!'),
                                          ),
                                        ],
                                      );
                                    } else if (state is AddingAnswerFailState) {
                                      return AlertDialog(
                                        title: const Text('Failure'),
                                        content: Text(state.error),
                                        actions: [
                                          TextButton(
                                            onPressed: () => context.pop(),
                                            child: const Text('Okay'),
                                          ),
                                        ],
                                      );
                                    } else if (state is AddingAnswerState) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );
                              },
                            );
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
                            child: const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
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
          ],
        ),
      ),
    );
  }
}
