import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m_tunes/screens/allpage.dart';
import 'package:m_tunes/presentation/root/widgets/hymns.dart'; // Hymns Screen
import 'package:m_tunes/common/helpers/is_dark_mode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController; // TabController to manage the tabs
  String userInitials = ''; // User initials to be displayed
  int _navBarIndex = 0; // To track the current bottom nav index

  @override
  void initState() {
    super.initState();
    _loadUserInitials(); // Load user initials from Firebase
    _tabController = TabController(length: 4, vsync: this); // TabController with 4 tabs
  }

  // Function to extract and load the user's initials from Firebase
  void _loadUserInitials() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.displayName != null) {
      String displayName = currentUser.displayName!;
      setState(() {
        userInitials = displayName[0].toUpperCase(); // Take the first initial
      });
    } else {
      setState(() {
        userInitials = 'U'; // Default value if no initials found
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose TabController when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAppBar(),
            _tabs(),
            SizedBox(
              height: 400,
              child: TabBarView(
                controller: _tabController, // Tab Controller to manage the TabBarView
                children: [
                  const AllPage(), // "All" Page
                  const HymnsScreen(), // "Hymns" Page (You can further customize this)
                  Center(child: Text('Files Content')), // Placeholder for "Files" Page
                  Center(child: Text('Tunes Content')), // Placeholder for "Tunes" Page
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // AppBar with user initials and app logo
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0), // Add padding to the left
        child: GestureDetector(
          onTap: () {
            // Navigate to Profile page when CircleAvatar is tapped
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (BuildContext context) => const ProfilePage()), // Navigate to Profile Page
            // );
          },
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(
              userInitials,
              style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0), // Add padding to the right
          child: const Icon(Icons.notifications, color: Colors.blue),
        ),
      ],
    );
  }

  // TabBar for switching between All, Hymns, Files, and Tunes
  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: Colors.purple,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      tabs: const [
        Text(
          'All',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Hymns',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Files',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Tunes',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }

  // Bottom navigation bar for app-wide navigation (Home, Search, Settings)
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _navBarIndex,
      onTap: (int index) {
        setState(() {
          _navBarIndex = index;
          if (index == 0) {
            // Switch to the 'All' tab when the "Home" button is pressed
            _tabController.animateTo(0);
          }
        });
      },
      backgroundColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: _navBarIndex == 0 ? Colors.blue : Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: _navBarIndex == 1 ? Colors.blue : Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: _navBarIndex == 2 ? Colors.blue : Colors.white),
          label: '',
        ),
      ],
    );
  }
}
