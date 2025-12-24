import 'package:flutter/material.dart';
import 'package:smart_grocery/screens/receipt_scan_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showOptions = false; // To toggle Scan/Manual buttons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1B5E20),
        title: const Text(
          "Smart Grocery",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 360,
          height: 780,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1B5E20),
                Color(0xFF2E7D32),
                Color(0xFF66BB6A),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.4, 1.0],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Main Scrollable Content
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100), // Space for FAB
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Bar with Menu and Cart
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.menu_rounded, size: 28, color: Color(0xFF1B5E20)),
                              ),
                              const Expanded(
                                child: Text(
                                  'Smart Grocery',
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Stack(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.shopping_cart_rounded, size: 28, color: Color(0xFF1B5E20)),
                                  ),
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(color: Color(0xFFFF6B6B), shape: BoxShape.circle),
                                      child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Search Bar + Notification
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 3))],
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF1B5E20)),
                                    hintText: 'Search groceries...',
                                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 3))],
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.notifications_rounded, size: 26, color: Color(0xFF1B5E20)),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Categories Title
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Categories',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Categories Grid
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.95,
                          children: [
                            _buildCategoryCard('Dairy', '🥛', const Color(0xFFFFF3E0), const Color(0xFFFFB74D)),
                            _buildCategoryCard('Fruits', '🍎', const Color(0xFFFFEBEE), const Color(0xFFEF5350)),
                            _buildCategoryCard('Vegetables', '🥕', const Color(0xFFE8F5E9), const Color(0xFF66BB6A)),
                            _buildCategoryCard('Breads', '🍞', const Color(0xFFFFF8E1), const Color(0xFFFFD54F)),
                            _buildCategoryCard('Pantry', '🥫', const Color(0xFFF3E5F5), const Color(0xFFAB47BC)),
                            _buildCategoryCard('Frozen', '🧊', const Color(0xFFE1F5FE), const Color(0xFF29B6F6)),

                          ],
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),

                // Floating Plus Button (Fixed Bottom Right)
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Option 1: Scan Receipt
                      if (_showOptions)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            elevation: 8,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => const ReceiptScanScreen()));

                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.camera_alt, color: Color(0xFF1B5E20)),
                                    SizedBox(width: 10),
                                    Text('Scan Receipt', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),

                      // Option 2: Manual Entry
                      if (_showOptions)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            elevation: 8,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {

                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.edit, color: Color(0xFF1B5E20)),
                                    SizedBox(width: 10),
                                    Text('Manual Entry', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),

                      // Main Plus Button
                      FloatingActionButton(
                        backgroundColor: const Color(0xFF66BB6A),
                        elevation: 10,
                        onPressed: () {
                          setState(() {
                            _showOptions = !_showOptions;
                          });
                        },
                        child: Icon(
                          _showOptions ? Icons.close : Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String emoji, Color bgColor, Color accentColor) {
    return InkWell(
      onTap: () {
        // Navigate to category items
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bgColor, bgColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 50)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: accentColor.withOpacity(0.9)),
            ),
          ],
        ),
      ),
    );
  }
}