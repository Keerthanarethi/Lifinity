import 'package:flutter/material.dart';

import '../../services/task_manager.dart';
import '../../services/goal_manager.dart';
import '../../services/storage_service.dart';
import '../../services/notification_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  String userName = "User";
  String wakeTime = "06:00 AM";
  String sleepTime = "11:00 PM";

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {

    String? savedName =
        await StorageService.getUserName();

    String savedWakeTime =
        await StorageService.getWakeTime();

    String savedSleepTime =
        await StorageService.getSleepTime();

    setState(() {
      userName =
          savedName ?? "User";

      wakeTime =
          savedWakeTime;

      sleepTime =
          savedSleepTime;
    });
  }

  Future<void> pickWakeTime() async {

    TimeOfDay? picked =
        await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {

      String formatted =
          picked.format(context);

      await StorageService
          .saveWakeTime(
        formatted,
      );

      setState(() {
        wakeTime = formatted;
      });
    }
  }

  Future<void> pickSleepTime() async {

    TimeOfDay? picked =
        await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {

      String formatted =
          picked.format(context);

      await StorageService
          .saveSleepTime(
        formatted,
      );

      setState(() {
        sleepTime = formatted;
      });
    }
  }

  Future<void> editName() async {

  TextEditingController controller =
      TextEditingController(
    text: userName,
  );

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Edit Name"),

        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter your name",
          ),
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () async {

              await StorageService
                  .saveUserName(
                controller.text.trim(),
              );

              setState(() {
                userName =
                    controller.text.trim();
              });

              if (!mounted) return;

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {

    int totalTasks =
        TaskManager.tasks.length;

    int completedTasks =
        TaskManager.tasks
            .where(
              (task) =>
                  task.completed,
            )
            .length;

    int totalGoals =
        GoalManager.goals.length;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F9FD),

      appBar: AppBar(
        title:
            const Text("Profile"),
        backgroundColor:
            Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 50,
              backgroundColor:
                  Color(0xFF6C4DFF),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            GestureDetector(
  onTap: editName,

  child: Row(
    mainAxisAlignment:
        MainAxisAlignment.center,

    children: [

      Text(
        userName,
        style: const TextStyle(
          fontSize: 26,
          fontWeight:
              FontWeight.bold,
        ),
      ),

      const SizedBox(width: 8),

      const Icon(
        Icons.edit,
        size: 20,
        color: Color(0xFF6C4DFF),
      ),
    ],
  ),
),

            const SizedBox(
              height: 30,
            ),

            GestureDetector(
              onTap: pickWakeTime,

              child: _buildCard(
                icon:
                    Icons.wb_sunny,
                title:
                    "Wake Time",
                value:
                    wakeTime,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            GestureDetector(
              onTap: pickSleepTime,

              child: _buildCard(
                icon:
                    Icons.nightlight,
                title:
                    "Sleep Time",
                value:
                    sleepTime,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Container(
              padding:
                  const EdgeInsets
                      .all(20),

              decoration:
                  BoxDecoration(
                color:
                    Colors.white,
                borderRadius:
                    BorderRadius
                        .circular(
                            20),
              ),

              child: Column(
                children: [

                  const Text(
                    "Statistics",
                    style:
                        TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  ListTile(
                    leading:
                        const Icon(
                      Icons.task,
                    ),
                    title:
                        const Text(
                      "Total Tasks",
                    ),
                    trailing:
                        Text(
                      "$totalTasks",
                    ),
                  ),

                  ListTile(
                    leading:
                        const Icon(
                      Icons
                          .check_circle,
                    ),
                    title:
                        const Text(
                      "Completed Tasks",
                    ),
                    trailing:
                        Text(
                      "$completedTasks",
                    ),
                  ),

                  ListTile(
                    leading:
                        const Icon(
                      Icons.flag,
                    ),
                    title:
                        const Text(
                      "Goals",
                    ),
                    trailing:
                        Text(
                      "$totalGoals",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
  height: 25,
),

SizedBox(
  width: double.infinity,

  child: ElevatedButton.icon(
    onPressed: () async {

      await StorageService.logout();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (route) => false,
      );
    },

    icon: const Icon(Icons.logout),

    label: const Text("Logout"),

    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
  ),
),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                20),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color:
                const Color(
              0xFF6C4DFF,
            ),
          ),

          const SizedBox(
            width: 15,
          ),

          Expanded(
            child: Text(
              title,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight
                        .bold,
              ),
            ),
          ),

          Text(value),

          const SizedBox(
            width: 10,
          ),

          const Icon(
            Icons.edit,
            size: 18,
          ),
        ],
      ),
    );
  }
}