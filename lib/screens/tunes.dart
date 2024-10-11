import 'package:flutter/material.dart';

class TunesScreen extends StatelessWidget {
  const TunesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Tunes'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Tunes Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
