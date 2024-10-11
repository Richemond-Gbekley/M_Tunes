import 'package:flutter/material.dart';
import 'package:m_tunes/screens/favourites.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:m_tunes/screens/hymns.dart'; // Import HymnsScreen
import 'package:m_tunes/screens/hymnlist.dart'; // Import HymnDetailScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = false; // To track if a song is playing
  String lastPlayedSong = 'The Coming King'; // Last played song
  String userInitials = ''; // User initials to be displayed

  int _tabBarIndex = 0; // To track the current tab index
  int _navBarIndex = 0; // To track the current bottom nav index

  // Placeholder for hymn details; can be updated when navigating to the detail page
  String selectedHymnCategory = '';
  List<String> selectedHymns = [];

  // This will hold the pages that correspond to each tab
  final List<Widget> _pages = [
    Center(child: Text('All Content')), // Placeholder for "All" page
    HymnsScreen(onCategorySelected: (String category, List<String> hymns) {  },), // Hymns page
    Center(child: Text('Files Content')), // Placeholder for "Files" page
    Center(child: Text('Tunes Content')), // Placeholder for "Tunes" page
    // HymnDetailScreen is not added here; it will be handled dynamically
  ];

  // Helper method to toggle song playing state
  void _togglePlaying() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserInitials();
  }

  // Function to extract and load the user's initials from Firebase
// Function to extract and load the user's initials from Firebase
  void _loadUserInitials() {
    User? currentUser = FirebaseAuth.instance.currentUser; // Get the current user

    // Check if the user is logged in and has a display name
    if (currentUser != null && currentUser.displayName != null) {
      String displayName = currentUser.displayName!; // Get the display name

      // Extract just the first letter of the display name
      setState(() {
        userInitials = displayName[0].toUpperCase(); // Take the first initial
      });
    } else {
      // Handle case where display name is not set
      setState(() {
        userInitials = 'U'; // Default to 'U' or any other default value
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Add space to move the top section down
            const SizedBox(height: 30),  // Adjust height as needed to move the tabs down

            // Top navigation row with SafeArea
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(userInitials, style: const TextStyle(color: Colors.black)), // Display user initials
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _tabBarIndex = 0; // Mark 'All' as current page
                      });
                    },
                    child: Text(
                      "ALL",
                      style: TextStyle(color: _tabBarIndex == 0 ? Colors.purple : Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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

            // Main content area that changes based on _tabBarIndex
            Expanded(
              child: IndexedStack(
                index: _tabBarIndex,
                children: [
                  _pages[0], // All Content page
                  // Pass the callback to navigate to hymn detail
                  HymnsScreen(
                    onCategorySelected: (category, hymns) {
                      setState(() {
                        selectedHymnCategory = category;
                        selectedHymns = hymns;
                        _tabBarIndex = 4; // Move to Hymn detail page
                      });
                    },
                  ),
                  _pages[2], // Files Content page
                  _pages[3], // Tunes Content page
                  // HymnDetailScreen will be shown here based on user selection
                  HymnDetailScreen(category: selectedHymnCategory, hymns: selectedHymns),
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
}
