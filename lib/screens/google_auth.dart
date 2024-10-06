import 'package:flutter/material.dart';

class GoogleAuthScreen extends StatelessWidget {
  const GoogleAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Optional: Set background color
      body: Column(
        children: [
          // Back button at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                // Navigate back to the Main page
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white, // Change to your desired color
                  ),
                  SizedBox(width: 8),
                  SizedBox(height: 100),

                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'This is the Google Authentication Page',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
