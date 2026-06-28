import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '/screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/startup_screen.dart';
import 'services/task_manager.dart'; 
import 'services/notification_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await NotificationService.initialize();
  await TaskManager.loadTasks();

  runApp(const LifinityApp());
}

class LifinityApp extends StatelessWidget {
  const LifinityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const StartupScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
      },
    );
  }
}