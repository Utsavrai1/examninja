import 'package:examninja/teacher/model/question_model.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddQuestionAlertDialogBox extends StatefulWidget {
  final String examId;

  const AddQuestionAlertDialogBox({super.key, required this.examId});

  @override
  State<AddQuestionAlertDialogBox> createState() =>
      _AddQuestionAlertDialogBoxState();
}

class _AddQuestionAlertDialogBoxState extends State<AddQuestionAlertDialogBox> {
  final ValueNotifier<int> optionCorrect = ValueNotifier<int>(-1);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionsController =
      List.generate(4, (index) => TextEditingController());
  final List<QuestionModel> questions = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40,
            top: -40,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: questionController,
                    maxLines: 5,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.only(
                          right: 20, left: 20, top: 10, bottom: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintStyle:
                          TextStyle(fontSize: 16, color: Colors.grey.shade700),
                      hintText: "Type Question...",
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.trim().isEmpty) {
                          return 'Enter a valid question';
                        } else {
                          return null;
                        }
                      } else {
                        return 'Enter a valid question';
                      }
                    },
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: optionCorrect,
                  builder: (context, value, child) => Column(
                    children: List.generate(
                      optionsController.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          controller: optionsController[index],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintStyle: TextStyle(
                                fontSize: 16, color: Colors.grey.shade700),
                            hintText: "Option ${index + 1}",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    optionCorrect.value = index;
                                  });
                                }
                              },
                              child: optionCorrect.value == index
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: Icon(
                                        Icons.done,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.done,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          validator: (value) {
                            if (value != null) {
                              if (value.trim().isEmpty) {
                                return 'Enter a valid option';
                              } else {
                                return null;
                              }
                            } else {
                              return 'Enter a valid option';
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (optionCorrect.value == -1) {
                            await showDialog<void>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content:
                                        const Text('Select a correct option'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: const Text('Okay'),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            QuestionModel question = QuestionModel(
                                examId: widget.examId,
                                question: questionController.text,
                                options: List.generate(
                                        4,
                                        (index) =>
                                            optionsController[index].text)
                                    .join(','),
                                correctOption:
                                    optionsController[optionCorrect.value]
                                        .text);

                            questions.add(question);
                            questionController.clear();
                            for (var controller in optionsController) {
                              controller.clear();
                            }
                            optionCorrect.value = -1;

                            context.read<TeacherBloc>().add(
                                  AddingQuestionEvent(question: question),
                                );

                            showDialog(
                              context: context,
                              builder: (_) {
                                return BlocConsumer<TeacherBloc, TeacherState>(
                                  listener: (context, state) async {
                                    if (state is QuestionCreatedSuccessState) {
                                      context.read<TeacherBloc>().add(
                                          GettingQuestionEvent(
                                              examId: widget.examId));
                                      if (state
                                          is GettingQuestionSuccessState) {
                                        context.pop();
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is QuestionCreatedSuccessState) {
                                      return AlertDialog(
                                        title: const Text('Success!'),
                                        content: const Text(
                                            'Question Added successfully'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => context.pop(),
                                            child: const Text('Great!'),
                                          ),
                                        ],
                                      );
                                    } else if (state
                                        is QuestionCreatedFailState) {
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
                                    } else if (state is CreateQuestionState) {
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
                          }
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
