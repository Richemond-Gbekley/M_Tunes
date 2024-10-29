import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m_tunes/common/helpers/is_dark_mode.dart';
import 'package:m_tunes/common/widgets/appbar/app_bar.dart';
import 'package:m_tunes/data/models/auth/login_user_req.dart';
import 'package:m_tunes/domain/usecases/auth/login.dart';
import 'package:m_tunes/presentation/auth/screens/signup.dart';
import 'package:m_tunes/screens/home_Screen.dart';
import 'package:m_tunes/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to show the forgot password dialog
  void _showForgotPasswordDialog() {
    final TextEditingController emailDialogController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Reset Password',
            style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                Text(
                  'Enter your email address to reset your password.',
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailDialogController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: context.isDarkMode ? Colors.white54 : Colors.black54,
                    ),
                    filled: true,
                    fillColor: context.isDarkMode ? Colors.white12 : Colors.grey[100],
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String email = emailDialogController.text;
                if (email.isNotEmpty) {
                  try {
                    await _auth.sendPasswordResetEmail(email: email);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password reset email sent')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Login function using Firebase Authentication
  void _login() async {
    var result  = await sl<LoginUseCase>().call(
        params: LoginUserReq(
            email: emailController.text.toString(),
            password: passwordController.text.toString(),
          )
    );
    result.fold(
            (l){
          var snackbar = SnackBar (content: Text(l),behavior: SnackBarBehavior.floating,);
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        },
            (r){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder:(BuildContext context ) => const HomeScreen()),
                  (route) => false
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  _SignupText(context),
      body: Stack(
        children: [
          const BasicAppbar(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log In',
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 100),

                    // Email Input Field
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          color: context.isDarkMode ? Colors.white54 : Colors.black54,
                        ),
                        filled: true,
                        fillColor: context.isDarkMode ? Colors.white12 : Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password Input Field
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          color: context.isDarkMode ? Colors.white54 : Colors.black54,
                        ),
                        filled: true,
                        fillColor: context.isDarkMode ? Colors.white12 : Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E17EB),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: context.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // "Forgot Password" Button
                    TextButton(
                      onPressed: _showForgotPasswordDialog,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: context.isDarkMode ? Colors.white : Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Sign up Text at the bottom
  Widget _SignupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account? ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SignUpScreen(),
                ),// Handle navigation to Login screen
              );
            },
            child: Text(
              'Sign Up Now',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
