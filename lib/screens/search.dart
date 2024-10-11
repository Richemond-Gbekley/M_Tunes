import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Search Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
