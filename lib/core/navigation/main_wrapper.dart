import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/dashboard/presentation/main_page.dart';
import 'package:kitahack_2026/features/nutrition/presentation/snap_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MainPage(), // Home Page
    const SnapPage(), // TODO : Snap Page
    const Center(child: Text("3rd Page")), // TODO: Profile Page
    // const ProfileScreen(), // Profile Page
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double textFontSize = 14;

    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        shape: const CircleBorder(),
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.add, color: colorScheme.primaryContainer),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Left Item: Home
              _buildNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: "Home",
                index: 0,
                colorScheme: colorScheme,
              ),

              // Empty space in the middle for the FloatingActionButton
              const SizedBox(width: 40),

              // Right Item: Profile
              _buildNavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: "Profile",
                index: 2,
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   selectedFontSize: textFontSize,
      //   unselectedFontSize: textFontSize,
      //   selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      //   unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       activeIcon: Icon(Icons.home),
      //       label: "Home",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outline),
      //       activeIcon: Icon(Icons.person),
      //       label: "Profile",
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required ColorScheme colorScheme,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? colorScheme.primary : Colors.grey;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isSelected ? activeIcon : icon, color: color),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
