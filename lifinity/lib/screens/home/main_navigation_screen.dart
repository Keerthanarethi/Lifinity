import 'package:flutter/material.dart';

import '../tasks/tasks_screen.dart';
import '../goals/goals_screen.dart';
import '../ai/ai_screen.dart';
import '../profile/profile_screen.dart';
import '../calendar/calendar_screen.dart';
import 'home_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final String userName;

  const MainNavigationScreen({
    super.key,
    required this.userName,
  });

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final List<Widget> screens = [

      HomeScreen(
        userName: widget.userName,
      ),

      const TasksScreen(),

      const CalendarScreen(),

      const GoalsScreen(),

      const AiScreen(),

      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        selectedItemColor:
            const Color(0xFF6C4DFF),

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Tasks",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Calendar",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: "Goals",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: "AI",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}