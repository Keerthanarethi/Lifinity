import 'package:flutter/material.dart';

import '../../services/storage_service.dart';
import '../home/main_navigation_screen.dart';
import 'login_screen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() =>
      _StartupScreenState();
}

class _StartupScreenState
    extends State<StartupScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {

    bool isLoggedIn =
        await StorageService.getLoginStatus();

    String? userName =
        await StorageService.getUserName();

    if (!mounted) return;

    if (isLoggedIn && userName != null) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              MainNavigationScreen(
            userName: userName,
          ),
        ),
      );
    } else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}