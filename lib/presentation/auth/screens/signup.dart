import 'package:flutter/material.dart';
import 'package:m_tunes/data/models/auth/create_user_req.dart';
import 'package:m_tunes/domain/usecases/auth/signup.dart';
import 'package:m_tunes/presentation/auth/screens/login.dart';
import 'package:m_tunes/screens/home_Screen.dart';
import 'package:m_tunes/common/helpers/is_dark_mode.dart';
import 'package:m_tunes/common/widgets/appbar/app_bar.dart';
import 'package:m_tunes/service_locator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false; // State variable to manage password visibility

  // Controllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  DateTime? dob; // Date of Birth

  String gender = '';
  int currentStep = 0; // Track current step
  String errorMessage = ''; // To display validation error messages

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dob) {
      setState(() {
        dob = picked; // Set the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _loginText(context), // Corrected the widget name

      body: SafeArea(
        child: Stack(
          children: [
            const BasicAppbar(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SignupText(),
                const SizedBox(height: 80), // Space from the top (for back arrow & title)
                if (currentStep == 0) _buildEmailStep(),   // Email Step
                if (currentStep == 1) _buildPasswordStep(), // Password Step
                if (currentStep == 2) _buildDobStep(),      // Date of Birth Step
                if (currentStep == 3) _buildGenderStep(),   // Gender Step
                if (currentStep == 4) _buildNameStep(),     // Name Step

                // Display error message if there is one
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),

                _buildNavigationButtons(),  // Next/Previous buttons
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Title: Sign Up Text
  Widget _SignupText() {
    return const Text(
      'Sign Up',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  // Login Text at the bottom
  Widget _loginText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Do you have an account? ',
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
                  builder: (BuildContext context) => const LoginScreen(),
              ),// Handle navigation to Login screen
              );
            },
            child: Text(
              'Log in',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Email input
  Widget _buildEmailStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start (left)
        children: [
          Text(
            'What\'s your Email',
            style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20), // Space between text and input field
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Enter Email',
              filled: true,
              fillColor: context.isDarkMode ? Colors.black : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: context.isDarkMode ? Colors.white : Colors.purple, width: 2),
              ),
            ),
            style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

  // Step 2: Password input
  Widget _buildPasswordStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start (left)
        children: [
          Text(
            'Enter Password',
            style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: 'Enter Password',
              filled: true,
              fillColor: context.isDarkMode ? Colors.black : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: context.isDarkMode ? Colors.white : Colors.purple, width: 2),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white54,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                  });
                },
              ),
            ),
            style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

  // Step 3: Date of Birth input using Date Picker
  Widget _buildDobStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Enter Date of Birth',
            style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              decoration: BoxDecoration(
                color: context.isDarkMode ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: context.isDarkMode ? Colors.white : Colors.purple, width: 2),
              ),
              child: Text(
                dob == null ? 'Select Date of Birth' : '${dob!.toLocal()}'.split(' ')[0],
                style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step 4: Gender selection
  Widget _buildGenderStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start (left)
        children: [
          Text(
            'Select Gender',
            style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: gender.isEmpty ? null : gender,
            dropdownColor: context.isDarkMode ? Colors.black : Colors.white,
            hint: Text('Select Gender', style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black)),
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (value) {
              setState(() {
                gender = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  // Step 5: Name input
  Widget _buildNameStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start (left)
        children: [
          Text(
            'Enter Name',
            style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Enter Name',
              filled: true,
              fillColor: context.isDarkMode ? Colors.black : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: context.isDarkMode ? Colors.white : Colors.purple, width: 2),
              ),
            ),
            style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

  // Next and Previous buttons
  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentStep > 0)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentStep--; // Go back
                });
              },
              child: Text(
                'Previous',
                style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          if (currentStep < 4)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentStep++; // Move forward
                });
              },
              child: Text(
                'Next',
                style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          if (currentStep == 4)
            ElevatedButton(
              onPressed: _validateAndSubmit,
              child: Text(
                'Register',
                style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  // Function to validate input fields and display error message
  void _validateAndSubmit() {
    setState(() async {
      errorMessage = ''; // Clear error message initially

      if (emailController.text.isEmpty) {
        errorMessage = 'Email is required';
      } else if (passwordController.text.isEmpty) {
        errorMessage = 'Password is required';
      } else if (dob == null) {
        errorMessage = 'Date of Birth is required';
      } else if (gender.isEmpty) {
        errorMessage = 'Gender is required';
      } else if (nameController.text.isEmpty) {
        errorMessage = 'Name is required';
      } else {
        // Call Firebase sign-up method

        var result  = await sl<SignupUseCase>().call(
          params: CreateUserReq(
              email: emailController.text.toString(),
              password: passwordController.text.toString(),
              name: nameController.text.toString(),
              gender: gender,
              dob: dob!)
        );
        result.fold(
                (l){
                  var snackbar = SnackBar (content: Text(l),behavior: SnackBarBehavior.floating);
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
    }});


  }
}
