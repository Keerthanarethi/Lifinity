import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskManager {

  static List<Task> tasks = [];

  static Future<void> saveTasks() async {

    final prefs =
        await SharedPreferences.getInstance();

    List<String> taskList = tasks
        .map(
          (task) => jsonEncode(
            task.toJson(),
          ),
        )
        .toList();

    await prefs.setStringList(
      'tasks',
      taskList,
    );
  }

  static Future<void> loadTasks() async {

    final prefs =
        await SharedPreferences.getInstance();

    List<String>? taskList =
        prefs.getStringList('tasks');

    if (taskList == null) {
      tasks = [];
      return;
    }

    tasks = taskList
        .map(
          (task) => Task.fromJson(
            jsonDecode(task),
          ),
        )
        .toList();
  }
}