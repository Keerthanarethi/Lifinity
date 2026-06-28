import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/goal.dart';

class GoalManager {
  static List<Goal> goals = [];

  static Future<void> saveGoals() async {
    final prefs =
        await SharedPreferences.getInstance();

    List<String> goalList = goals
        .map(
          (goal) => jsonEncode(
            goal.toJson(),
          ),
        )
        .toList();

    await prefs.setStringList(
      'goals',
      goalList,
    );
  }

  static Future<void> loadGoals() async {
    final prefs =
        await SharedPreferences.getInstance();

    List<String>? goalList =
        prefs.getStringList('goals');

    if (goalList == null) return;

    goals = goalList
        .map(
          (goal) => Goal.fromJson(
            jsonDecode(goal),
          ),
        )
        .toList();
  }
}