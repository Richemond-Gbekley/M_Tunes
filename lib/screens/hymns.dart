import 'package:flutter/material.dart';
import 'package:m_tunes/screens/hymnlist.dart';

class HymnsScreen extends StatefulWidget {
  final Function(String category, List<String> hymns) onCategorySelected; // Callback to pass selected category and hymns

  const HymnsScreen({super.key, required this.onCategorySelected}); // Update constructor

  @override
  _HymnsScreenState createState() => _HymnsScreenState();
}

class _HymnsScreenState extends State<HymnsScreen> {
  // Hymn categories and their respective hymns
  final Map<String, List<String>> hymnCategories = {
    'Deeper Life': ['Hymn 1', 'Hymn 2', 'Hymn 3'],
    'Methodist': ['Hymn A', 'Hymn B', 'Hymn C'],
    'Baptist': ['Hymn X', 'Hymn Y', 'Hymn Z'],
    'Catholic': ['Hymn M', 'Hymn N', 'Hymn O'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: hymnCategories.keys.length,
          itemBuilder: (context, index) {
            String category = hymnCategories.keys.elementAt(index);

            return Card(
              color: Colors.grey[850],
              child: ListTile(
                title: Text(
                  category,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () {
                  // Call the callback with selected category and hymns
                  widget.onCategorySelected(category, hymnCategories[category]!);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
