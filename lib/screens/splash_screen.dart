import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smart_grocery/screens/home_screen.dart';
import 'package:smart_grocery/screens/login_screen.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;
  late List<Animation<Offset>> _featureAnimations;

  @override
  void initState() {
    super.initState();


    // Animation controller for 5 seconds total
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Logo fades/slides in quickly at the start
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    ));

    // Four features slide up staggered
    _featureAnimations = List.generate(4, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 1.0), // Start from bottom
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.3 + index * 0.15, // Start after logo, delay each by 0.15s
          0.8 + index * 0.05, // Finish quickly
          curve: Curves.easeOutBack,
        ),
      ));
    });

    // Start the animation
    _controller.forward();

    // Navigate to home after ~6 seconds
    Timer(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          height: 780,
          color: const Color(0xFFFFF9F7),
          child: Column(
            children: [
              // Logo and titles (animated slightly)
              SlideTransition(
                position: _logoAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 65.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE8D6),
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                ),
              ),

              SlideTransition(
                position: _logoAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: const Text(
                    'SmartGrocery',
                    style: TextStyle(
                      fontSize: 31,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),

              SlideTransition(
                position: _logoAnimation,
                child: const Text(
                  'Your smart kitchen companion\nfor zero waste living',
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),

              // Feature 1
              SlideTransition(
                position: _featureAnimations[0],
                child: _buildFeatureContainer(
                  icon: Icons.camera_alt_rounded,
                  text: 'Scan receipts instantly with AI',
                ),
              ),

              // Feature 2
              SlideTransition(
                position: _featureAnimations[1],
                child: _buildFeatureContainer(
                  icon: Icons.notifications_active_rounded,
                  text: 'Get alerts before items expire',
                ),
              ),

              // Feature 3
              SlideTransition(
                position: _featureAnimations[2],
                child: _buildFeatureContainer(
                  icon: Icons.people_rounded,
                  text: 'Share inventory with Family',
                ),
              ),

              // Feature 4
              SlideTransition(
                position: _featureAnimations[3],
                child: _buildFeatureContainer(
                  icon: Icons.restaurant_menu_rounded,
                  text: 'Smart recipe suggestions',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureContainer({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: 300,
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE8D6),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 8.0),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(icon, color: Colors.black54),
              ),
            ),
            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

