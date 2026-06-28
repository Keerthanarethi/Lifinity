import 'package:flutter/material.dart';
import '../home/main_navigation_screen.dart';
import '../../services/storage_service.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final TextEditingController nameController =
      TextEditingController();

  bool study = true;
  bool fitness = false;
  bool medicine = false;
  bool work = false;
  bool personal = false;

  String wakeTime = "06:00 AM";
  String sleepTime = "11:00 PM";

  Future<void> continueToHome() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your name"),
        ),
      );
      return;
    }

    await StorageService.saveUserName(
      nameController.text.trim(),
    );

    await StorageService.saveLoginStatus(
      true,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MainNavigationScreen(
          userName:
              nameController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Welcome to Lifinity 👋",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Let's personalize your experience",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "What should we call you?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter your name",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Wake Up Time",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

           GestureDetector(
  onTap: () async {
    TimeOfDay? pickedTime =
        await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        sleepTime =
           "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  },
  child: Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(14),
    ),
    child: Text(sleepTime),
  ),
),

            const SizedBox(height: 25),

            const Text(
              "Sleep Time",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Text(sleepTime),
            ),

            const SizedBox(height: 30),

            const Text(
              "What would you like to manage?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            CheckboxListTile(
              value: study,
              onChanged: (value) {
                setState(() {
                  study = value!;
                });
              },
              title: const Text("Study"),
            ),

            CheckboxListTile(
              value: fitness,
              onChanged: (value) {
                setState(() {
                  fitness = value!;
                });
              },
              title: const Text("Fitness"),
            ),

            CheckboxListTile(
              value: medicine,
              onChanged: (value) {
                setState(() {
                  medicine = value!;
                });
              },
              title: const Text("Medicine"),
            ),

            CheckboxListTile(
              value: work,
              onChanged: (value) {
                setState(() {
                  work = value!;
                });
              },
              title: const Text("Work"),
            ),

            CheckboxListTile(
              value: personal,
              onChanged: (value) {
                setState(() {
                  personal = value!;
                });
              },
              title: const Text("Personal"),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: continueToHome,

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF6C4DFF),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),

                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
