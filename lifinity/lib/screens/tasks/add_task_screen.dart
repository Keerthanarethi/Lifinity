import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../services/task_manager.dart';
import '../../services/notification_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() =>
      _AddTaskScreenState();
}

class _AddTaskScreenState
    extends State<AddTaskScreen> {

  final TextEditingController taskController =
      TextEditingController();

  String repeatType = "Daily";
  bool alarmEnabled = true;

  String selectedTime = "Not Set";

  String selectedDate =
      DateTime.now().toString().split(' ')[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Task Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: "Enter task name",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Repeat",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: repeatType,

              items: const [
                DropdownMenuItem(
                  value: "Daily",
                  child: Text("Daily"),
                ),
                DropdownMenuItem(
                  value: "Weekly",
                  child: Text("Weekly"),
                ),
                DropdownMenuItem(
                  value: "Monthly",
                  child: Text("Monthly"),
                ),
                DropdownMenuItem(
                  value: "Yearly",
                  child: Text("Yearly"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  repeatType = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              "Task Time",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () async {

                  TimeOfDay? pickedTime =
                      await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    setState(() {
                      selectedTime =
                          "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
                    });
                  }
                },

                child: Text(
                  selectedTime,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Task Date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

                  DateTime? pickedDate =
                      await showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.now(),
                    firstDate:
                        DateTime(2025),
                    lastDate:
                        DateTime(2035),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate =
                          pickedDate
                              .toString()
                              .split(' ')[0];
                    });
                  }
                },

                child: Text(
                  selectedDate,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text(
                "Enable Alarm",
              ),

              value: alarmEnabled,

              onChanged: (value) {
                setState(() {
                  alarmEnabled = value;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () async {

                  if (taskController.text
                      .trim()
                      .isEmpty) {

                    ScaffoldMessenger.of(
                            context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Enter task name",
                        ),
                      ),
                    );

                    return;
                  }

                  final task = Task(
  id: DateTime.now().millisecondsSinceEpoch,
  title: taskController.text.trim(),
  category: "General",
  time: selectedTime,
  repeatType: repeatType,
  date: selectedDate,
  alarmEnabled: alarmEnabled,
);

TaskManager.tasks.add(task);

                  await TaskManager.saveTasks();

                  if (!mounted) return;

                  Navigator.pop(
                    context,
                  );
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xFF6C4DFF,
                  ),
                ),

                child: const Text(
                  "Save Task",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}