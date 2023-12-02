import 'package:examninja/teacher/navbar/teacher_navbar.dart';
import 'package:examninja/teacher/teacher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WebAddExamScreen extends StatelessWidget {
  WebAddExamScreen({super.key});

  final List<String> subjects = [
    'Mathematics',
    'Physics',
    'Computer Science',
    'Chemistry',
    'Biology'
  ];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<String?> subject = ValueNotifier<String?>(null);
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController marksController = TextEditingController();

  final ValueNotifier<String> classOfStudent = ValueNotifier<String>('');

  final List<String> availableClass = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th',
    '9th',
    '10th',
    '11th',
    '12th'
  ];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime.now()) {
      dateController.text = picked.toLocal().toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TeacherCustomNavbar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: size.width * (0.5),
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Class',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    items: availableClass.map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        classOfStudent.value = newValue;
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding:
                          const EdgeInsets.only(right: 10, left: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.trim().isEmpty) {
                          return 'Select a valid class';
                        } else {
                          return null;
                        }
                      } else {
                        return 'Select a valid class';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Subject',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    items: subjects.map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      subject.value = newValue;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding:
                          const EdgeInsets.only(right: 10, left: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.trim().isEmpty) {
                          return 'Select a valid subject';
                        } else {
                          return null;
                        }
                      } else {
                        return 'Select a valid subject';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Title',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding:
                          const EdgeInsets.only(right: 20, left: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.trim().isEmpty) {
                          return 'Enter a valid title';
                        } else {
                          return null;
                        }
                      } else {
                        return 'Enter a valid title';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Duration (in minutes)',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: durationController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding:
                          const EdgeInsets.only(right: 20, left: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.trim().isEmpty) {
                          return 'Enter a valid duration';
                        } else {
                          return null;
                        }
                      } else {
                        return 'Enter a valid duration';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Total Marks',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: marksController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding:
                          const EdgeInsets.only(right: 20, left: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.trim().isEmpty) {
                          return 'Enter a valid marks';
                        } else {
                          return null;
                        }
                      } else {
                        return 'Enter a valid marks';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'End Date',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: dateController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () => _selectDate(context),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding:
                          const EdgeInsets.only(right: 20, left: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.trim().isEmpty) {
                          return 'Select a valid date';
                        } else {
                          return null;
                        }
                      } else {
                        return 'Select a valid date';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<TeacherBloc>().add(
                              AttemptingExamCreatingEvent(
                                duration: int.parse(durationController.text),
                                marks: int.parse(marksController.text),
                                subject: subject.value!,
                                title: titleController.text,
                                endDate: dateController.text,
                                classOfStudent: classOfStudent.value,
                              ),
                            );

                        showDialog(
                          context: context,
                          builder: (_) {
                            return BlocConsumer<TeacherBloc, TeacherState>(
                              listener: (context, state) async {
                                if (state is ExamCreatedSuccessState) {}
                              },
                              builder: (context, state) {
                                if (state is ExamCreatedSuccessState) {
                                  return AlertDialog(
                                    title: const Text('Success!'),
                                    content:
                                        const Text('Exam Added successfully'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: const Text('Great!'),
                                      ),
                                    ],
                                  );
                                } else if (state is ExamCreatedFailState) {
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
                                } else if (state is CreateExamState) {
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
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                        ),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        width: 400,
                        child: const Center(
                          child: Text(
                            "Add Exam",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
