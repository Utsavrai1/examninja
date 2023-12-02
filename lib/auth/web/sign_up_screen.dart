import 'package:email_validator/email_validator.dart';
import 'package:examninja/auth/auth_bloc.dart';
import 'package:examninja/auth/login_screen.dart';
import 'package:examninja/storage/local_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WebSignUpScreen extends StatefulWidget {
  const WebSignUpScreen({super.key});

  @override
  State<WebSignUpScreen> createState() => _WebSignUpScreenState();
}

class _WebSignUpScreenState extends State<WebSignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordVisible = ValueNotifier<bool>(false);

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final List<String> userTypes = ['Student', 'Teacher'];

  final ValueNotifier<String?> userType = ValueNotifier<String?>(null);

  final ValueNotifier<String?> classOfStudent = ValueNotifier<String?>(null);

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

  isUserLoggedIn() async {
    final userType =
        await LocalStorageService().getDataFromStorage('user_type');
    if (userType == 'Admin') {
      if (context.mounted) {
        context.pushNamed('AdminHome');
      }
    } else if (userType == 'Student') {
      if (context.mounted) {
        context.pushNamed('StudentHome');
      }
    } else if (userType == 'Teacher') {
      if (context.mounted) {
        context.pushNamed('TeacherHome');
      }
    }
    return null;
  }

  @override
  void initState() {
    isUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      width: size.width * (0.3),
                      padding: const EdgeInsets.all(20),
                      child: Card(
                        color: Colors.white.withOpacity(0.7),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        elevation: 20,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.deepPurple.shade400,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                              ),
                              child: DropdownButtonFormField(
                                items: userTypes.map((String category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  userType.value = newValue;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.people,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  contentPadding: const EdgeInsets.only(
                                      right: 10, left: 20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade700),
                                  hintText: "User",
                                ),
                                validator: (value) {
                                  if (value != null) {
                                    if (value.trim().isEmpty) {
                                      return 'Select a valid user';
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return 'Select a valid user';
                                  }
                                },
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: userType,
                              builder: (context, value, child) {
                                return value == 'Student'
                                    ? Column(children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            right: 20,
                                            left: 20,
                                          ),
                                          child: DropdownButtonFormField(
                                            items: availableClass
                                                .map((String category) {
                                              return DropdownMenuItem(
                                                value: category,
                                                child: Text(category),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              classOfStudent.value = newValue;
                                            },
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                Icons.people,
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade100,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      right: 10, left: 20),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none),
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey.shade700),
                                              hintText: "Class",
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
                                        ),
                                      ])
                                    : Container();
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                              ),
                              child: TextFormField(
                                controller: nameController,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    contentPadding: const EdgeInsets.only(
                                        right: 20, left: 20),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700),
                                    hintText: "Name"),
                                validator: (value) {
                                  if (value != null) {
                                    if (value.trim().isEmpty) {
                                      return 'Enter a valid name';
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return 'Enter a valid name';
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                              ),
                              child: TextFormField(
                                controller: emailController,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                        Icons.alternate_email_rounded),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    contentPadding: const EdgeInsets.only(
                                        right: 20, left: 20),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700),
                                    hintText: "Email-id"),
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ValueListenableBuilder(
                                valueListenable: passwordVisible,
                                builder: (_, value, __) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        right: 20, left: 20),
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: !value,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.password_rounded),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            passwordVisible.value =
                                                !passwordVisible.value;
                                          },
                                          icon: value
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: Colors.grey.shade500,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.grey.shade500,
                                                ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        contentPadding: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none),
                                        hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade700),
                                        hintText: "Password",
                                      ),
                                      validator: (value) {
                                        if (value != null) {
                                          if (value.trim().isEmpty) {
                                            return 'Enter a valid password';
                                          } else if (value.trim().length < 6) {
                                            return 'Entered password is not strong';
                                          } else {
                                            return null;
                                          }
                                        } else {
                                          return 'Enter a valid password';
                                        }
                                      },
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                right: 40,
                                left: 40,
                              ),
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.deepPurple.shade400,
                                  Colors.deepPurple.shade400
                                ]),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              width: 400,
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                          AttemptingSignUpEvent(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              userType: userType.value!,
                                              classOfStudent:
                                                  classOfStudent.value),
                                        );

                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return BlocConsumer<AuthBloc,
                                            AuthState>(
                                          listener: (context, state) async {
                                            if (state is SignUpSuccessState) {
                                              if (state.userType == 'Admin') {
                                                if (context.mounted) {
                                                  context
                                                      .pushNamed('AdminHome');
                                                }
                                              } else if (state.userType ==
                                                  'Student') {
                                                if (context.mounted) {
                                                  context
                                                      .pushNamed('StudentHome');
                                                }
                                              } else if (state.userType ==
                                                  'Teacher') {
                                                if (context.mounted) {
                                                  context
                                                      .pushNamed('TeacherHome');
                                                }
                                              }
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state is SignUpSuccessState) {
                                              return AlertDialog(
                                                title: const Text('Success!'),
                                                content: const Text(
                                                    'SingUp in successfully'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        context.pop(),
                                                    child: const Text('Great!'),
                                                  ),
                                                ],
                                              );
                                            } else if (state
                                                is SignUpFailState) {
                                              return AlertDialog(
                                                title: const Text('Failure'),
                                                content: Text(state.error),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        context.pop(),
                                                    child: const Text('Okay'),
                                                  ),
                                                ],
                                              );
                                            } else if (state is SignUpState) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
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
                                icon: const Icon(
                                  Icons.login_rounded,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "SignUp",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // Center(
                            //   child: RichText(
                            //     text: TextSpan(
                            //       text: 'Forgot',
                            //       style: const TextStyle(
                            //           color: Colors.black, fontSize: 16),
                            //       children: <TextSpan>[
                            //         TextSpan(
                            //           text: ' Password?',
                            //           style: const TextStyle(
                            //               color: Colors.deepPurple,
                            //               fontSize: 16),
                            //           recognizer: TapGestureRecognizer()
                            //             ..onTap = () {},
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Already have an account?',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' LogIn',
                                      style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 16),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ),
                                          );
                                        },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
