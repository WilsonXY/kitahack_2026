import 'package:flutter/material.dart';

// --- Theme Colors ---
const Color kMangoPrimary = Color(0xFFFF8C00);
const Color kMangoAccent = Color(0xFFFFB300);
const Color kMangoBackground = Color(0xFFFFF3E0);
const Color kTextBrown = Color(0xFF4E342E);
const Color kPlaceholderGrey = Color(0xFFBDBDBD);

class SnapMangoApp extends StatelessWidget {
  const SnapMangoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapMango',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kMangoPrimary,
        scaffoldBackgroundColor: kMangoBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: kMangoPrimary,
          foregroundColor: kMangoBackground,
          elevation: 4,
          shadowColor: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: kTextBrown),
          titleLarge: TextStyle(color: kTextBrown, fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: kMangoAccent,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/snap': (context) => const SnapPage(),
        '/history': (context) => const HistoryPage(),
        // We can pass arguments to the result page later
        '/result': (context) => const ResultPage(),
      },
    );
  }
}

// ==================== 1. MAIN PAGE & HAMBURGER MENU ====================

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnapMango!'),
      ),
      drawer: const SnapMangoDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // --- Section 1: The Big Snap Button ---
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: Ink(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: kMangoPrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: kMangoAccent, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: kTextBrown.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        // small delay
                        Future.delayed(const Duration(milliseconds: 100), () {
                          if (!context.mounted) return;
                          Navigator.pushNamed(context, '/snap');
                        });
                      },
                      borderRadius: BorderRadius.circular(100),
                      splashColor: kMangoAccent.withValues(alpha: 0.5),
                      highlightColor: Colors.transparent, 
                      child: const Center(
                        child: Text(
                          'Snap!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: kMangoBackground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),

              // --- Section 2: History ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'History',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    child: const Text('See All', style: TextStyle(color: kMangoPrimary)),
                  ),
                ],
              ),
              // const SizedBox(height: 3),
              
              ListView.builder(
                shrinkWrap: true, 
                physics: const NeverScrollableScrollPhysics(), 
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const HistorySummaryItem();
                },
              ),

              const SizedBox(height: 30),

              // --- Section 3: Future Content (e.g., Daily Tips) ---
              const Text(
                'Daily Mango Tips', 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 15),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: kMangoAccent),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb, color: kMangoPrimary, size: 30),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        "Did you know? Mangos are rich in Vitamin C! Snap your snack to track your intake.",
                        style: TextStyle(color: kTextBrown, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- Section 4: Another Future Section (e.g., Stats) ---
              const Text(
                'Your Week', 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 15),
              
              // Placeholder for a chart or stats
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPlaceholderGrey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    '[Weekly Stats Placeholder]',
                    style: TextStyle(color: kTextBrown.withValues(alpha: 0.5)),
                  ),
                ),
              ),
              
              const SizedBox(height: 50), // Bottom padding for scrolling
            ],
          ),
        ),
      ),
    );
  }
}

// The Drawer (Hamburger Menu)
class SnapMangoDrawer extends StatelessWidget {
  const SnapMangoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kMangoBackground,
        child: Column(
          children: [
            // --- Drawer Header ---
            DrawerHeader(
              decoration: const BoxDecoration(
                color: kMangoPrimary,
                borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45, // Custom shadow color
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    CircleAvatar(
                      backgroundColor: kMangoAccent,
                      radius: 30,
                      child: Icon(Icons.person, color: kTextBrown, size: 35),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hi, [username]',
                      style: TextStyle(
                        color: kMangoBackground,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- Menu Items ---
            _buildDrawerItem(
              context: context,
              icon: Icons.camera_alt,
              title: 'Snap',
              routeName: '/snap',
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.history,
              title: 'History',
              routeName: '/history',
            ),
            
            const Spacer(), // push the button to bottom 
            
            // logout
            _buildDrawerItem(
              context: context,
              icon: Icons.logout,
              title: 'Logout',
              routeName: '/', // TODO: placeholder
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper method to create animation on drawer items
  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String routeName,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // The Mango Wave
        splashColor: kMangoPrimary.withValues(alpha: 0.2),
        highlightColor: kMangoAccent.withValues(alpha: 0.1),
        onTap: () {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (!context.mounted) return;
            Navigator.pop(context); // close drawer first
            Navigator.pushNamed(context, routeName);
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Icon(icon, color: kMangoPrimary, size: 28),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  color: kTextBrown,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder widget for history items on the main page
class HistorySummaryItem extends StatelessWidget {
  const HistorySummaryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent, 
        child: Ink(
          height: 100,
          decoration: BoxDecoration(
            color: kPlaceholderGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: Colors.white.withValues(alpha: .3),
            onTap: () {
              Future.delayed(const Duration(milliseconds: 80), () {
                if (!context.mounted) return;
                Navigator.pushNamed(context, '/result');
              });
            },
            child: const Center(
              // TODO: content goes here (e.g., text, icon)
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== 2. SNAP PAGE (Capture Image) ====================

class SnapPage extends StatelessWidget {
  const SnapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Camera Preview Placeholder
          Positioned.fill(
            child: Container(
              color: Colors.grey[850],
              child: const Center(
                child: Text('Camera Preview', style: TextStyle(color: Colors.white54)),
              ),
            ),
          ),
          // Framing Corners (Top Left)
          Positioned(
            top: 130,
            left: 40,
            child: Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: kMangoAccent, width: 3), left: BorderSide(color: kMangoAccent, width: 3))
              )
            ),
          ),
           // Framing Corners (Top Right)
          Positioned(
            top: 130,
            right: 40,
            child: Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: kMangoAccent, width: 3), right: BorderSide(color: kMangoAccent, width: 3))
              )
            ),
          ),
           // Framing Corners (Bottom Left)
          Positioned(
            bottom: 250,
            left: 40,
            child: Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: kMangoAccent, width: 3), left: BorderSide(color: kMangoAccent, width: 3))
              )
            ),
          ),
          // Framing Corners (Bottom Right)
          Positioned(
            bottom: 250,
            right: 40,
            child: Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: kMangoAccent, width: 3), right: BorderSide(color: kMangoAccent, width: 3))
              )
            ),
          ),
          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // --- Capture Button ---
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kMangoPrimary, width: 2),
                      color: Colors.transparent, 
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        // Small delay to let user see the ripple
                        Future.delayed(const Duration(milliseconds: 100), () {
                          if (!context.mounted) return;
                          Navigator.pushReplacementNamed(context, '/result');
                        });
                      },
                      splashColor: kMangoPrimary,
                      child: Container(
                        width: 90,
                        height: 90,
                        padding: const EdgeInsets.all(4),
                        child: const CircleAvatar(
                          backgroundColor: kMangoPrimary,
                          child: Icon(Icons.camera_alt, color: Colors.white, size: 35),
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

                // --- Animated Gallery Button ---
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: kMangoPrimary.withValues(alpha: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      splashColor: kMangoAccent.withValues(alpha: .8),
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          if (!context.mounted) return;
                          Navigator.pushReplacementNamed(context, '/result');
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: const Text(
                          'Gallery', 
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ==================== 3. RESULT PAGE & SHARE POP-OUT ====================

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- 1. Image Placeholder (Fixed Size) ---
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: kPlaceholderGrey,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                   BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                   )
                ]
              ),
              child: const Icon(Icons.fastfood, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 20),
            
            // --- 2. Food Name ---
            const Text(
              'Food Name Placeholder',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // --- 3. Analysis Report Output (Expanded to fill space) ---
            Expanded(
              child: Container(
                width: double.infinity,
                // Removed fixed height, using Expanded instead
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Changed to white for better readability
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kMangoAccent.withValues(alpha: 0.5)),
                ),
                child: const SingleChildScrollView(
                  // scrollable text in case report is long
                  child: Text(
                    '(Gemini generated report goes here) \n\n'
                    'Calories: 350 kcal\n'
                    'Carbs: 45g\n'
                    'Protein: 12g\n'
                    'Fat: 10g\n\n'
                    '...',
                    style: TextStyle(fontSize: 16, color: kTextBrown, height: 1.5),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),

            // --- 4. Share and Download Row ---
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showSharePopOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kMangoPrimary,
                      foregroundColor: kMangoBackground,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    icon: const Icon(Icons.share),
                    label: const Text('Share', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                // Download Icon Button
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    width: 60, // Fixed width to match height (square)
                    height: 60, // Match the height of the Share button
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kMangoPrimary, width: 2),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: kMangoPrimary.withValues(alpha: 0.2),
                      highlightColor: kMangoPrimary.withValues(alpha: 0.1),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Saving to device..."),
                              backgroundColor: kMangoPrimary,
                              duration: Duration(milliseconds: 500),
                            )
                        );
                      },
                      child: const Center(
                        child: Icon(Icons.download, color: kMangoPrimary, size: 28),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // The Share Pop-out (Modal Bottom Sheet)
  void _showSharePopOut(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kMangoBackground,
      isScrollControlled: true, // Allows sheet to be taller if needed
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          height: 500, // Slightly taller for better visibility
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 6,
                decoration: BoxDecoration(
                  color: kPlaceholderGrey,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              const SizedBox(height: 20),
              const Text('Share Result', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextBrown)),
              const SizedBox(height: 20),
              // Generated Report Preview Placeholder
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kMangoPrimary, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4)
                      )
                    ]
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: kPlaceholderGrey),
                        SizedBox(height: 10),
                        Text(
                          '(Generated Report Image)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kTextBrown, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Social Media Button Placeholders
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialIcon(Icons.facebook, Colors.blue),
                  _buildSocialIcon(Icons.alternate_email, Colors.black), // X
                  _buildSocialIcon(Icons.message, Colors.green), // WhatsApp
                  _buildSocialIcon(Icons.more_horiz, kMangoPrimary),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: color.withValues(alpha: 0.3),
          onTap: () {
            // TODO: action for social share
          },
          child: Center(
            child: Icon(icon, color: color, size: 30),
          ),
        ),
      ),
    );
  }
}


// ==================== 4. HISTORY PAGE ====================

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Page'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5, // Simulate 5 history items
        itemBuilder: (context, index) {

          // Inside HistoryPage ListView.builder...
          return Card(
            color: kMangoBackground,
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: kMangoAccent, width: 1),
            ),
            clipBehavior: Clip.antiAlias, // Important: clips the ripple to the card rounded corners
            child: InkWell(
              splashColor: kMangoPrimary.withValues(alpha: 0.2), // The wave color
              onTap: () {
                Future.delayed(const Duration(milliseconds: 100), () {
                          if (!context.mounted) return;
                          Navigator.pushNamed(context, '/result');
                        });
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          color: kPlaceholderGrey,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Icon(Icons.image, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Mango Salad', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 8),
                            Text('(brief explanation...)', style: TextStyle(color: kTextBrown)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: kMangoPrimary)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
