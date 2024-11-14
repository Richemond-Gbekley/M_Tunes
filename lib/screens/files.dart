import 'package:flutter/material.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Files'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Files Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
