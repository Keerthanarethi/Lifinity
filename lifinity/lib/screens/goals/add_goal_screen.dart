import 'package:flutter/material.dart';
import '../../models/goal.dart';
import '../../services/goal_manager.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() =>
      _AddGoalScreenState();
}

class _AddGoalScreenState
    extends State<AddGoalScreen> {

  final titleController =
      TextEditingController();

  final targetController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Goal"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Goal Name",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: targetController,
              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                labelText: "Target",
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () async {

                  if (titleController.text
                          .trim()
                          .isEmpty ||
                      targetController.text
                          .trim()
                          .isEmpty) {
                    return;
                  }

                  GoalManager.goals.add(
                    Goal(
                      title:
                          titleController.text,
                      progress: 0,
                      target: int.parse(
                        targetController.text,
                      ),
                    ),
                  );

                  await GoalManager
                      .saveGoals();

                  if (!mounted) return;

                  Navigator.pop(
                    context,
                  );
                },

                child: const Text(
                  "Save Goal",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}