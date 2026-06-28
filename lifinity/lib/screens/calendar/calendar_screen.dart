import 'package:flutter/material.dart';
import '../../services/task_manager.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() =>
      _CalendarScreenState();
}

class _CalendarScreenState
    extends State<CalendarScreen> {

  int selectedDay = DateTime.now().day;

  @override
  Widget build(BuildContext context) {

    final selectedTasks =
        TaskManager.tasks.where((task) {

      if (task.date.isEmpty) {
        return false;
      }

      DateTime taskDate =
          DateTime.parse(task.date);

      return taskDate.day == selectedDay;

    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF8F7FC),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Calendar",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // Calendar Card
            Container(
              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(25),
              ),

              child: Column(
                children: [

                  const Text(
                    "June 2026",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Colors.deepPurple,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  GridView.builder(
                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    itemCount: 30,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                    ),

                    itemBuilder:
                        (context, index) {

                      int day =
                          index + 1;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay =
                                day;
                          });
                        },

                        child: Container(
                          margin:
                              const EdgeInsets
                                  .all(4),

                          decoration:
                              BoxDecoration(
                            color:
                                selectedDay ==
                                        day
                                    ? Colors
                                        .deepPurple
                                    : Colors
                                        .transparent,

                            shape:
                                BoxShape.circle,
                          ),

                          child: Center(
                            child: Text(
                              "$day",

                              style:
                                  TextStyle(
                                color:
                                    selectedDay ==
                                            day
                                        ? Colors
                                            .white
                                        : Colors
                                            .black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Selected Date Card
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(25),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Selected Date",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "$selectedDay June ${DateTime.now().year}",
                    style:
                        const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Task Count: ${selectedTasks.length}",
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    "Tasks",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  if (selectedTasks.isEmpty)
                    const Text(
                      "No tasks found",
                    )
                  else
                    Column(
                      children:
                          selectedTasks.map(
                        (task) {
                          return ListTile(
                            leading: Icon(
                              task.completed
                                  ? Icons
                                      .check_circle
                                  : Icons
                                      .radio_button_unchecked,
                              color: task
                                      .completed
                                  ? Colors
                                      .green
                                  : Colors
                                      .grey,
                            ),

                            title: Text(
                              task.title,
                            ),

                            subtitle: Text(
                              "${task.time} • ${task.repeatType}",
                            ),
                          );
                        },
                      ).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}