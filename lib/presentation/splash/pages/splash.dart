import 'package:flutter/material.dart';
import 'package:m_tunes/core/configs/assets/app_vectors.dart';
import 'package:m_tunes/presentation/intro/get_started.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    redirect();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome Text with custom font
            Text(
              'Welcome to M Tunes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                // fontFamily: '',  // Use the custom font family
              ),
            ),
            const SizedBox(height: 20),
            // Logo Image
            CircleAvatar(
              radius: 100,
              child: Image.asset(AppVectors.logo),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> redirect () async{
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const GetStartedScreen()
    )
    );
  }

}

