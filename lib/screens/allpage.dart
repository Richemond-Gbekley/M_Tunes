import 'package:flutter/material.dart';

class AllPage extends StatelessWidget {
  const AllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Two buttons per row
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: [
        _buildFeatureButton(
          context,
          'Favourites',
          Icons.favorite,
          Colors.blue,
              () {
            // Navigate to Favourites screen

          },
        ),
        _buildFeatureButton(
          context,
          'Playlist',
          Icons.playlist_play,
          Colors.blue,
              () {
            // Navigate to Playlist screen
          },
        ),
        _buildFeatureButton(
          context,
          'Downloads',
          Icons.download,
          Colors.blue,
              () {
            // Navigate to Downloads screen
          },
        ),
        _buildFeatureButton(
          context,
          'History',
          Icons.history,
          Colors.blue,
              () {
            // Navigate to History screen
          },
        ),
      ],
    );
  }

  // Helper method to build a feature button
  Widget _buildFeatureButton(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [color, Colors.black],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            SizedBox(height: 10),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
