import 'package:flutter/material.dart';

import '../../services/storage_service.dart';
import '../home/main_navigation_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool hidePassword = true;

  Future<void> login() async {

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all fields",
          ),
        ),
      );

      return;
    }

    String? savedEmail =
        await StorageService
            .getAccountEmail();

    String? savedPassword =
        await StorageService
            .getAccountPassword();

    if (savedEmail == null ||
        savedPassword == null) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please create an account first",
          ),
        ),
      );

      return;
    }

    if (emailController.text.trim() ==
            savedEmail &&
        passwordController.text.trim() ==
            savedPassword) {

      await StorageService
          .saveLoginStatus(true);

      String? accountName =
          await StorageService
              .getAccountName();

      if (accountName != null) {
        await StorageService
            .saveUserName(
          accountName,
        );
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MainNavigationScreen(
            userName:
                accountName ?? "User",
          ),
        ),
      );
    } else {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Invalid email or password",
          ),
        ),
      );
    }
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
                  height: 20,
                ),

                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Text(
                  "Sign in to continue",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                SizedBox(
                  width: 320,
                  child: TextField(
                    controller:
                        emailController,
                    decoration:
                        InputDecoration(
                      hintText: "Email",
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
                  height: 15,
                ),

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
                      suffixIcon:
                          IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons
                                  .visibility_off
                              : Icons
                                  .visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword =
                                !hidePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  width: 320,
                  child: Align(
                    alignment:
                        Alignment
                            .centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  width: 320,
                  height: 50,
                  child:
                      ElevatedButton(
                    onPressed:
                        login,
                    child:
                        const Text(
                      "Login",
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  "or continue with",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                SizedBox(
                  width: 320,
                  height: 50,
                  child:
                      OutlinedButton
                          .icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons
                          .g_mobiledata,
                    ),
                    label: const Text(
                      "Google",
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  children: [

                    const Text(
                      "Don't have an account?",
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const SignUpScreen(),
                          ),
                        );
                      },
                      child:
                          const Text(
                        "Sign Up",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
