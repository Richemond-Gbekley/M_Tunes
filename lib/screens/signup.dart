import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_tunes/screens/home_Screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false; // State variable to manage password visibility
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance

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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Back arrow and "Sign Up" text positioned at the top
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Back arrow
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // "Sign Up" text centered
            Positioned(
              top: 50,
              left: 145,
              right: 145,
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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

  // Step 1: Email input
  Widget _buildEmailStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start (left)
        children: [
          const Text(
            'What\'s your Email',
            style: TextStyle(
              color: Colors.white,
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
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.purple, width: 2),
              ),
            ),
            style: const TextStyle(color: Colors.white),
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
          const Text(
            'Enter Password',
            style: TextStyle(
              color: Colors.white,
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
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.purple, width: 2),
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
            style: const TextStyle(color: Colors.white),
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
          const Text(
            'Enter Date of Birth',
            style: TextStyle(
              color: Colors.white,
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
                color: Colors.white12,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.purple, width: 2),
              ),
              child: Text(
                dob == null ? 'Select Date of Birth' : '${dob!.toLocal()}'.split(' ')[0],
                style: const TextStyle(color: Colors.white),
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
          const Text(
            'Select Gender',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: gender.isEmpty ? null : gender,
            dropdownColor: Colors.black,
            hint: const Text('Select Gender', style: TextStyle(color: Colors.white54)),
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
          const Text(
            'Enter Name',
            style: TextStyle(
              color: Colors.white,
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
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.purple, width: 2),
              ),
            ),
            style: const TextStyle(color: Colors.white),
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
              child: const Text('Previous'),
            ),
          if (currentStep < 4)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentStep++; // Move forward
                });
              },
              child: const Text('Next'),
            ),
          if (currentStep == 4)
            ElevatedButton(
              onPressed: _validateAndSubmit,
              child: const Text('Submit'),
            ),
        ],
      ),
    );
  }

  // Function to validate input fields and display error message
  void _validateAndSubmit() {
    setState(() {
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
        _saveUserData();
      }
    });
  }

  void _saveUserData() async {
    String email = emailController.text;
    String password = passwordController.text;
    String selectedGender = gender;
    String name = nameController.text;
    String dobString = dob != null ? '${dob!.toLocal()}'.split(' ')[0] : ''; // Formatting date

    // Create a new user in Firebase Authentication
    try {
      // Attempt to create a new user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user profile with the display name
      await userCredential.user?.updateProfile(displayName: nameController.text);

      // Navigate to HomeScreen after successful sign-up
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()), // Replace with your HomeScreen
        );
      }

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,
        'gender': selectedGender,
        'date_of_birth': dobString,
      });

      // Handle successful sign-up here
      print('Sign-Up Successful:');
      print('Email: $email');
      print('Name: $name');
      print('Date of Birth: $dobString');
      print('Gender: $selectedGender');

      // Reset the form and go back to the initial step
      setState(() {
        currentStep == 0;
        emailController.clear();
        passwordController.clear();
        dob = null;
        nameController.clear();
        gender = '';
      });

      // Optionally navigate to another screen here (check if mounted first)
     // if (mounted) {
       // Navigator.of(context).pushReplacementNamed('/nextScreen'); // Replace with your next screen route
      //}

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // The email is already in use
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Email Already in Use'),
              content: Text('The email address is already in use by another account.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      } else {
        // Handle other errors (optional)
        print("Error: ${e.message}");
      }
    } catch (e) {
      // Handle generic errors
      print("An error occurred: $e");
    }
  }


}
