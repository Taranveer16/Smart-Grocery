import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_grocery/screens/home_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  // true = Sign In active, false = Sign Up active
  bool isSignInActive = true;

  // Controllers
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController = TextEditingController();

  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();



  @override
  void dispose() {
    signInEmailController.dispose();
    signInPasswordController.dispose();
    signUpNameController.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    super.dispose();
  }

  // Function to switch to Sign In
  void switchToSignIn() {
    setState(() {
      isSignInActive = true;
    });
  }

  // Function to switch to Sign Up
  void switchToSignUp() {
    setState(() {
      isSignInActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          height: 780,
          color: AppColors.surface,
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
                style: AppTextStyles.appTitle,
              ),

              const SizedBox(height: 12),

              // Main Card
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  height: 470,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(14),
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
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Stack(
                            children: [
                              // 🟢 Sliding green highlight
                              AnimatedAlign(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                alignment:
                                isSignInActive ? Alignment.centerLeft : Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: Container(
                                    width: 100,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),

                              // Tabs text layer
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Sign In
                                  Expanded(
                                    child: InkWell(
                                      onTap: switchToSignIn,
                                      child: Center(
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: isSignInActive
                                                ? Colors.white
                                                :  AppColors.textPrimary.withAlpha(153),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Sign Up
                                  Expanded(
                                    child: InkWell(
                                      onTap: switchToSignUp,
                                      child: Center(
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: !isSignInActive
                                                ? Colors.white
                                                :  AppColors.textPrimary.withAlpha(153),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                  borderSide: BorderSide(color: AppColors.subtleCard),
                ),
                label: Text(
                  'Email',
                  style: TextStyle(fontSize: 15, color: AppColors.textPrimary.withAlpha(178), fontWeight: FontWeight.w700),
                ),
                prefixIcon:Icon(Icons.email_outlined, size: 20, color: AppColors.textPrimary.withAlpha(153)),
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
                  borderSide: BorderSide(color: AppColors.subtleCard),
                ),
                label: Text(
                  'Password',
                  style: TextStyle(fontSize: 15, color: AppColors.textPrimary.withAlpha(178), fontWeight: FontWeight.w700),
                ),
                prefixIcon: Icon(Icons.lock_outline, size: 20, color: AppColors.textPrimary.withAlpha(153)),
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
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.highlight),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Login Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent, // Mango Pop
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              // Login logic

            },
            child: Text(
              'Login',
              style: AppTextStyles.button,
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
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: AppColors.info),
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
                icon: FaIcon(FontAwesomeIcons.google, size: 22, color: AppColors.textPrimary.withAlpha(153)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text('|', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.facebook, size: 22,color: AppColors.textPrimary.withAlpha(153)),
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
                  style: AppTextStyles.body,
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
                  style: AppTextStyles.body,
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
                  style: AppTextStyles.body,
                ),
                prefixIcon: const Icon(Icons.lock_outline, size: 20, color: Colors.black54),
              ),
            ),
          ),

          const SizedBox(height: 15),


          const SizedBox(height: 20),

          // Sign Up Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent, // Mango Pop
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
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
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.info),
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
