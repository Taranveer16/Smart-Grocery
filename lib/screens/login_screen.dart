import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_grocery/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  // Tab colors
  Color fcolor1 = Colors.white;        // Sign In text
  Color bgcolor1 = const Color(0xFF2E7D32); // Sign In bg (active by default)

  Color fcolor2 = Colors.grey.shade200; // Sign Up text
  Color bgcolor2 = Colors.grey.shade300; // Sign Up bg

  // true = Sign In active, false = Sign Up active
  bool isSignInActive = true;

  // Controllers
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController = TextEditingController();

  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();
  final TextEditingController signUpReferralCodeController = TextEditingController();



  @override
  void dispose() {
    signInEmailController.dispose();
    signInPasswordController.dispose();
    signUpNameController.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpReferralCodeController.dispose();
    super.dispose();
  }

  // Function to switch to Sign In
  void switchToSignIn() {
    setState(() {
      isSignInActive = true;
      fcolor1 = Colors.white;
      bgcolor1 = const Color(0xFF2E7D32);
      fcolor2 = Colors.grey.shade200;
      bgcolor2 = Colors.grey.shade300;
    });
  }

  // Function to switch to Sign Up
  void switchToSignUp() {
    setState(() {
      isSignInActive = false;
      fcolor2 = Colors.white;
      bgcolor2 = const Color(0xFF2E7D32);
      fcolor1 = Colors.grey.shade200;
      bgcolor1 = Colors.grey.shade300;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          height: 780,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1B5E20),
                Color(0xFF2E7D32),
                Color(0xFF43A047),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/img/IMG_2.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Title
              const Text(
                'SmartGrocery',
                style: TextStyle(
                  color: Color(0xFFFFF8F0),
                  fontSize: 31,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 12),

              // Main Card
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  height: 470,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBEFEF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      // Toggle Tabs
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          width: 230,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Sign In Tab
                              InkWell(
                                onTap: switchToSignIn,
                                child: Container(
                                  width: 100,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: bgcolor1,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: fcolor1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Sign Up Tab
                              InkWell(
                                onTap: switchToSignUp,
                                child: Container(
                                  width: 100,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: bgcolor2,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: fcolor2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Dynamic Form Area
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: isSignInActive ? signInForm() : signUpForm(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sign In Form
  Widget signInForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),

          // Email
          SizedBox(
            width: 270,
            child: TextField(
              controller: signInEmailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                label: const Text(
                  'Email',
                  style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w700),
                ),
                prefixIcon: const Icon(Icons.email_outlined, size: 20, color: Colors.black54),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Password
          SizedBox(
            width: 270,
            child: TextField(
              controller: signInPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                label: const Text(
                  'Password',
                  style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w700),
                ),
                prefixIcon: const Icon(Icons.lock_outline, size: 20, color: Colors.black54),
              ),
            ),
          ),

          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 15.0),
              child: InkWell(
                onTap: () {
                  // Handle forgot password
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.red),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Login Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              elevation: 10,
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () {
              // Login logic

            },
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFFFF8F0)),
            ),
          ),

          const SizedBox(height: 12),

          // Don't have account
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black54),
              ),
              InkWell(
                onTap: switchToSignUp,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blueAccent),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          const Text('-----------------------------------------', style: TextStyle(color: Colors.black54)),
          const Text('OR Sign In with', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.google, size: 22, color: Colors.red),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text('|', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.facebook, size: 22, color: Colors.blue),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Sign Up Form
  Widget signUpForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),

          // Name
          SizedBox(
            width: 270,
            child: TextField(
              controller: signUpNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                label: const Text(
                  'Name',
                  style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w700),
                ),
                prefixIcon: const Icon(Icons.person, size: 20, color: Colors.black54),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Email
          SizedBox(
            width: 270,
            child: TextField(
              controller: signUpEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                label: const Text(
                  'Email',
                  style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w700),
                ),
                prefixIcon: const Icon(Icons.email_outlined, size: 20, color: Colors.black54),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Password
          SizedBox(
            width: 270,
            child: TextField(
              controller: signUpPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                label: const Text(
                  'Password',
                  style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w700),
                ),
                prefixIcon: const Icon(Icons.lock_outline, size: 20, color: Colors.black54),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Referral Code (Optional)
          SizedBox(
            width: 270,
            child: TextField(
              controller: signUpReferralCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                label: const Text(
                  'Referral Code (Optional)',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                prefixIcon: const Icon(Icons.card_giftcard, size: 20, color: Colors.black54),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Sign Up Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              elevation: 10,
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () {
              // Sign up logic
            },
            child: const Text(
              'Signup',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFFFF8F0)),
            ),
          ),

          const SizedBox(height: 12),

          // Already have account
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account? ',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black54),
              ),
              InkWell(
                onTap: switchToSignIn,
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blueAccent),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}



