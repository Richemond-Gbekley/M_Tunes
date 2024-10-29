import 'package:flutter/material.dart';
import 'package:m_tunes/common/helpers/is_dark_mode.dart';
import 'package:m_tunes/common/widgets/appbar/app_bar.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';
import 'package:m_tunes/presentation/hymn_player/pages/media.dart';

class HymnDetailScreen extends StatelessWidget {
  final HymnEntity hymn;

  const HymnDetailScreen({super.key, required this.hymn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(hymn.title), // Display the hymn title as the screen title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Artist: ${hymn.artist}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Hymn Number: ${hymn.hymn_number}', // Convert hymn_number to a String inline
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              hymn.lyrics, // Display the lyrics
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(), // Spacer to push the button to the bottom

            // Play button for hymn with label
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HymnPlayerScreen(hymnEntity: hymn,), // Target screen
                  ),
                );
              },
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Circular shape for the play button
                      color: context.isDarkMode
                          ? Colors.grey[800] // Dark mode color
                          : const Color(0xffE6E6E6), // Light mode color
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded, // Play icon
                      color: context.isDarkMode
                          ? Colors.grey[400] // Icon color in dark mode
                          : const Color(0xff555555), // Icon color in light mode
                    ),
                  ),
                  const SizedBox(width: 10), // Spacing between button and text
                  const Text(
                    'Play Hymn',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


