import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/signup.dart';
import 'screens/google_auth.dart';
import 'screens/apple_auth.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/home_screen.dart'; // Ensure this matches the actual file name

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Make sure Firebase initializes properly
  runApp(const MTunes());
}

class MTunes extends StatelessWidget {
  const MTunes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Main(),
        '/signup': (context) => const SignUpScreen(),
        '/google_auth': (context) => const GoogleAuthScreen(),
        '/apple_auth': (context) => const AppleAuthScreen(),
        '/login': (context) => const LoginScreen(),
        '/HomeScreen': (context) => const HomeScreen(),
      },
    );
  }
}
