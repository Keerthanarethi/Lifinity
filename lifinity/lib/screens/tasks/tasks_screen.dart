import 'package:flutter/material.dart';
import '../../services/task_manager.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() =>
      _TasksScreenState();
}

class _TasksScreenState
    extends State<TasksScreen> {

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    await TaskManager.loadTasks();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      appBar: AppBar(
        title: const Text("Tasks"),
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
                  const AddTaskScreen(),
            ),
          );

          setState(() {});
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: TaskManager.tasks.isEmpty
          ? const Center(
              child: Text(
                "No Tasks Yet",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.all(16),

              itemCount:
                  TaskManager.tasks.length,

              itemBuilder:
                  (context, index) {

                final task =
                    TaskManager.tasks[index];

                return Card(
                  margin:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),

                  child: ListTile(

                    leading: Checkbox(
                      activeColor:
                          const Color(
                        0xFF6C4DFF,
                      ),

                      value:
                          task.completed,

                      onChanged:
                          (value) async {

                        setState(() {
                          task.completed =
                              value!;
                        });

                        await TaskManager
                            .saveTasks();
                      },
                    ),

                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.completed
                                ? TextDecoration
                                    .lineThrough
                                : TextDecoration
                                    .none,

                        color:
                            task.completed
                                ? Colors.grey
                                : Colors.black,

                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          "${task.repeatType} • ${task.time}",
                        ),

                        const SizedBox(
                          height: 2,
                        ),

                        Text(
                          task.date,
                          style:
                              const TextStyle(
                            color: Colors
                                .deepPurple,
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      onPressed:
                          () async {

                        setState(() {
                          TaskManager.tasks
                              .removeAt(
                                  index);
                        });

                        await TaskManager
                            .saveTasks();
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}