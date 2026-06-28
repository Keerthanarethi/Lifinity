import 'package:flutter/material.dart';
import '../../services/storage_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() =>
      _SignUpScreenState();
}

class _SignUpScreenState
    extends State<SignUpScreen> {

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;

  Future<void> signUp() async {

    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text
            .trim()
            .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text("Please fill all fields"),
        ),
      );

      return;
    }

    if (passwordController.text !=
        confirmPasswordController.text) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text("Passwords do not match"),
        ),
      );

      return;
    }

    await StorageService.saveAccount(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password:
          passwordController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Account created successfully",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F9FD),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                const Icon(
                  Icons.all_inclusive,
                  size: 90,
                  color:
                      Color(0xFF6C4DFF),
                ),

                const SizedBox(
                    height: 20),

                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 30),

                SizedBox(
                  width: 320,
                  child: TextField(
                    controller:
                        nameController,
                    decoration:
                        InputDecoration(
                      hintText:
                          "Full Name",
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 15),

                SizedBox(
                  width: 320,
                  child: TextField(
                    controller:
                        emailController,
                    decoration:
                        InputDecoration(
                      hintText:
                          "Email",
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 15),

                SizedBox(
                  width: 320,
                  child: TextField(
                    controller:
                        passwordController,
                    obscureText:
                        hidePassword,
                    decoration:
                        InputDecoration(
                      hintText:
                          "Password",
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 15),

                SizedBox(
                  width: 320,
                  child: TextField(
                    controller:
                        confirmPasswordController,
                    obscureText:
                        hidePassword,
                    decoration:
                        InputDecoration(
                      hintText:
                          "Confirm Password",
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 25),

                SizedBox(
                  width: 320,
                  height: 50,
                  child:
                      ElevatedButton(
                    onPressed:
                        signUp,
                    child:
                        const Text(
                      "Sign Up",
                    ),
                  ),
                ),

                const SizedBox(
                    height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context);
                  },
                  child: const Text(
                    "Already have an account? Login",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
