import 'package:flutter/material.dart';
import 'package:m_tunes/core/configs/assets/app_vectors.dart';
import 'package:m_tunes/presentation/auth/screens/apple_auth.dart';
import 'package:m_tunes/presentation/auth/screens/google_auth.dart';
import 'package:m_tunes/presentation/auth/screens/login.dart';
import 'package:m_tunes/presentation/auth/screens/signup.dart';



class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Circular image
            CircleAvatar(
              radius: 100,
              child: Image.asset(AppVectors.logo),
              ),

            const SizedBox(height: 30),

            // "Sign up for free" button wrapped with GestureDetector for navigation
            GestureDetector(
              onTap: () {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
               builder: (BuildContext context) => SignUpScreen()
                )
              );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF5E17EB),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Sign up for free',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // "Continue with Google" button with an icon
            GestureDetector(
              onTap: () {
              Navigator.pushReplacement(
               context,
               MaterialPageRoute(
               builder: (BuildContext context) => GoogleAuthScreen()
                )
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),


                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/search.png',  // Add your custom Google icon here
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 10),  // Space between icon and text
                    const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // "Continue with Apple" button with an icon
            GestureDetector(
              onTap: () {
                     Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                     builder: (BuildContext context) => AppleAuthScreen()
                     )
                     );
                     },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/apple (1).png',  // Add your custom Apple icon here
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(width: 10),  // Space between icon and text
                    const Text(
                      'Continue with Apple',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // "Log in" button
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()
                    )
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
