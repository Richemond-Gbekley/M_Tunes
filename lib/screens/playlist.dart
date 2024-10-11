import 'package:flutter/material.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Playlist'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Playlist Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
