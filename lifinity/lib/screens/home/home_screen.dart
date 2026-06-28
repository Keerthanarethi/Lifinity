import 'package:flutter/material.dart';
import '../../services/task_manager.dart';
import '../../services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({
    super.key,
    required this.userName,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  String userName = "User";

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  Future<void> loadUserName() async {

    String? name =
        await StorageService.getUserName();

    setState(() {
      userName = name ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {

    String today =
        DateTime.now().toString().split(' ')[0];

    final todayTasks = TaskManager.tasks
        .where(
          (task) => task.date == today,
        )
        .toList();

    int totalTasks = todayTasks.length;

    int completedTasks = todayTasks
        .where((task) => task.completed)
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                "Good Morning, $userName 🌸",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFF6C4DFF),
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Today's Progress",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "$completedTasks / $totalTasks Tasks",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Expanded(
                child: todayTasks.isEmpty
                    ? Container(
                        padding:
                            const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(
                                  16),
                        ),

                        child: const Row(
                          children: [

                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            ),

                            SizedBox(width: 10),

                            Text(
                              "No tasks for today",
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            todayTasks.length,

                        itemBuilder:
                            (context, index) {

                          final task =
                              todayTasks[index];

                          return Card(
                            child: ListTile(
                              leading: Icon(
                                task.completed
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,

                                color:
                                    task.completed
                                        ? Colors.green
                                        : Colors.grey,
                              ),

                              title: Text(
                                task.title,
                              ),

                              subtitle: Text(
                                "${task.time} • ${task.repeatType}",
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}