import 'package:flutter/material.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Downloads'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Downloads Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
