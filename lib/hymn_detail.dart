import 'package:flutter/material.dart';

// HymnDetailView to display the actual hymn details
class HymnDetailView extends StatelessWidget {
  final String hymn;

  const HymnDetailView({
    required this.hymn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding for the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
            children: [
              // Back arrow at the top
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Go back when the arrow is tapped
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white, // Back arrow color
                    ),
                  ),
                  const SizedBox(width: 16), // Space between the arrow and the title
                  Text(
                    hymn,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Title color
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Space between the title and hymn details

              // Placeholder text for hymn details and lyrics
              Text(
                'Lyrics and details of the hymn go here...',
                style: const TextStyle(color: Colors.white), // Text color for details
              ),

              const Spacer(), // Spacer to push the button to the bottom

              // Play button for hymn
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow), // Play icon
                label: const Text('Play Hymn'), // Button text
                onPressed: () {
                  // Code to play the hymn audio goes here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
