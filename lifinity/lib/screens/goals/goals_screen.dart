import 'package:flutter/material.dart';
import '../../services/goal_manager.dart';
import 'add_goal_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() =>
      _GoalsScreenState();
}

class _GoalsScreenState
    extends State<GoalsScreen> {

  @override
  void initState() {
    super.initState();
    loadGoals();
  }

  Future<void> loadGoals() async {
    await GoalManager.loadGoals();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      appBar: AppBar(
        title: const Text("Goals"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            const Color(0xFF6C4DFF),

        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const AddGoalScreen(),
            ),
          );

          setState(() {});
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: GoalManager.goals.isEmpty
          ? const Center(
              child: Text(
                "No Goals Yet",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.all(16),

              itemCount:
                  GoalManager.goals.length,

              itemBuilder:
                  (context, index) {

                final goal =
                    GoalManager.goals[index];

                double percent =
                    goal.progress /
                        goal.target;

                return Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),

                  padding:
                      const EdgeInsets.all(
                          20),

                  decoration:
                      BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [

                          Text(
                            goal.title,
                            style:
                                const TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          IconButton(
                            icon:
                                const Icon(
                              Icons.delete,
                              color:
                                  Colors.red,
                            ),

                            onPressed:
                                () async {

                              GoalManager.goals
                                  .removeAt(
                                      index);

                              await GoalManager
                                  .saveGoals();

                              setState(() {});
                            },
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        "${goal.progress} / ${goal.target}",
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      LinearProgressIndicator(
                        value: percent,
                        minHeight: 10,
                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        "${(percent * 100).toInt()}% Completed",
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      ElevatedButton(
                        onPressed:
                            () async {

                          if (goal.progress <
                              goal.target) {

                            goal.progress++;

                            await GoalManager
                                .saveGoals();

                            setState(() {});
                          }
                        },

                        child: const Text(
                          "+ Progress",
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}