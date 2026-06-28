import 'package:flutter/material.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      appBar: AppBar(
        title: const Text("AI Assistant"),
      ),

      body: const Center(
        child: Text(
          "AI Coming Soon 🤖",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}