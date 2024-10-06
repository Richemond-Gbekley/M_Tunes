import 'package:flutter/material.dart';

class Hymn {
  final String title;
  final String lyrics;

  Hymn(this.title, this.lyrics);
}

class FavouritesScreen extends StatelessWidget {
  final List<Hymn> favouriteHymns; // List to hold the favorite hymns

  // Constructor
  const FavouritesScreen({super.key, required this.favouriteHymns});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Hymns'), // Title for the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favouriteHymns.isNotEmpty // Check if there are favorites
            ? ListView.builder(
          itemCount: favouriteHymns.length,
          itemBuilder: (context, index) {
            final hymn = favouriteHymns[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(hymn.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(hymn.lyrics),
                // Optionally, add an onTap to display more details
                onTap: () {
                  // You can navigate to a detailed view if needed
                },
              ),
            );
          },
        )
            : const Center(child: Text('No favorite hymns found.')), // Message if no favorites
      ),
    );
  }
}
 