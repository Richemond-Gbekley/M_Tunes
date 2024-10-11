import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'History Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
