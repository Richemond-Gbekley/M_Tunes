import 'package:flutter/material.dart';
import 'package:m_tunes/core/configs/assets/app_images.dart';
import 'package:m_tunes/core/configs/assets/app_vectors.dart';
import 'package:m_tunes/core/configs/theme/app_colors.dart';
import 'package:m_tunes/common/widgets/button/basic_app_button.dart';
import 'package:m_tunes/presentation/root/screens/home.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.introBG),
              ),
            ),
          ),
          // Black overlay
          Container(
            color: Colors.black.withOpacity(0.50),
          ),
          // Content of the screen
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            child: Column(
              children: [
                // App Logo
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 50,
                    child: Image.asset(AppVectors.logo),
                  ),
                ),
                const Spacer(),
                // Text: Enjoy listening to Hymns
                const Text(
                  'Enjoy listening to Hymns',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 21),
                // Description Text
                const Text(
                  'The Multilingual Mobile Hymnal App is a versatile and inclusive application aimed at providing a comprehensive hymn experience to users from diverse linguistic backgrounds.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Get Started Button
                BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Main(),
                      ),
                    );
                  },
                  title: 'Get Started',
                  height: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
