import 'package:flutter/material.dart';




class AppleAuthScreen extends StatelessWidget {
  const AppleAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Back button at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                // Navigate back to the Main page
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white, // Change to your desired color
                  ),
                  SizedBox(width: 8),
                  SizedBox(height: 0),

                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'This is the Apple Authentication Page',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}