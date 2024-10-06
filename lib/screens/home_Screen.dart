import 'package:flutter/material.dart';
import 'package:m_tunes/screens/favourites.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = false; // To track if a song is playing
  String lastPlayedSong = 'The Coming King'; // Last played song

  int _tabBarIndex = 0; // To track the current tab index
  int _navBarIndex = 0; // To track the current bottom nav index

  // Helper method to toggle song playing state
  void _togglePlaying() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top navigation row with SafeArea
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.blue), // Back button
                  ),

                ],
              ),
            ),

            // Tab bar row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text("RG", style: TextStyle(color: Colors.white)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to All page
                      setState(() {
                        _tabBarIndex = 0; // Mark 'All' as current page
                        _navBarIndex = 0; // Sync with home icon on bottom nav
                      });
                    },
                    child: Text(
                      "ALL",
                      style: TextStyle(color: _tabBarIndex == 0 ? Colors.purple : Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Hymns page
                      setState(() {
                        _tabBarIndex = 1; // Mark 'Hymns' as current page
                      });
                    },
                    child: Text(
                      "Hymns",
                      style: TextStyle(color: _tabBarIndex == 1 ? Colors.purple : Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Files page
                      setState(() {
                        _tabBarIndex = 2; // Mark 'Files' as current page
                      });
                    },
                    child: Text(
                      "Files",
                      style: TextStyle(color: _tabBarIndex == 2 ? Colors.purple : Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Tunes page
                      setState(() {
                        _tabBarIndex = 3; // Mark 'Tunes' as current page
                      });
                    },
                    child: Text(
                      "Tunes",
                      style: TextStyle(color: _tabBarIndex == 3 ? Colors.purple : Colors.white),
                    ),
                  ),
                  const Icon(Icons.notifications, color: Colors.blue),
                ],
              ),
            ),

            // Grid buttons (Favourites, Playlist, Downloads, History)
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16.0),
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildGridButton('Favourites', Icons.favorite, Colors.blue, screenHeight, () {
                    // Navigate to Favourites page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouritesScreen(favouriteHymns: [Hymn('Amazing Grace', 'Lyrics of Amazing Grace...'),
                          Hymn('How Great Thou Art', 'Lyrics of How Great Thou Art...'),],),
                      ),
                    );
                  }),
                  _buildGridButton('Playlist', Icons.playlist_play, Colors.blue, screenHeight, () {
                    // Navigate to Playlist page
                  }),
                  _buildGridButton('Downloads', Icons.download, Colors.blue, screenHeight, () {
                    // Navigate to Downloads page
                  }),
                  _buildGridButton('History', Icons.history, Colors.blue, screenHeight, () {
                    // Navigate to History page
                  }),
                ],
              ),
            ),

            // Music player section (visible only when a song is playing)
            if (isPlaying || lastPlayedSong.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lastPlayedSong, style: const TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: _togglePlaying,
                      child: Icon(
                        isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navBarIndex,
        onTap: (int index) {
          setState(() {
            _navBarIndex = index;
            // If the "home" icon is tapped, sync the tab to 'All'
            if (index == 0) {
              _tabBarIndex = 0;
            }
          });
        },
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _navBarIndex == 0 ? Colors.orange : Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _navBarIndex == 1 ? Colors.orange : Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: _navBarIndex == 2 ? Colors.orange : Colors.white),
            label: '',
          ),
        ],
      ),
    );
  }

  // Helper method to create grid buttons
  Widget _buildGridButton(String title, IconData icon, Color iconColor, double screenHeight, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.black],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: screenHeight * 0.05), // Responsive icon size
            SizedBox(height: screenHeight * 0.01),
            Text(title, style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.02)),
          ],
        ),
      ),
    );
  }
}
