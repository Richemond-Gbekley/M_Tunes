import 'package:flutter/material.dart';
import 'package:m_tunes/hymn_detail.dart';

// HymnDetailScreen to display a list of hymns in a selected category
class HymnDetailScreen extends StatelessWidget {
  final String category; // The category of hymns
  final List<String> hymns; // List of hymns in this category

  const HymnDetailScreen({
    required this.category,
    required this.hymns,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color for the screen
      body: SafeArea(
        child: Column(
          children: [
            // Display the category title at the top
            Padding(
              padding: const EdgeInsets.all(16.0), // Padding around the title
              child: Text(
                category, // Show the category name
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
            ),
            // ListView to display the hymns in the selected category
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0), // Padding for the hymn list
                itemCount: hymns.length, // Number of hymns
                itemBuilder: (context, index) {
                  String hymn = hymns[index]; // Get the hymn for this index

                  return Card(
                    color: Colors.grey[850], // Card background color
                    child: ListTile(
                      title: Text(
                        hymn, // Display the hymn name
                        style: const TextStyle(color: Colors.white), // Text color
                      ),
                      onTap: () {
                        // Navigate to the detailed view of the selected hymn
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HymnDetailView(hymn: hymn), // Pass the selected hymn
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
