import 'package:flutter/material.dart';
import 'package:kitahack_2026/features/dashboard/presentation/main_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MainPage(), // Home Page
    const Center(child: Text("2nd Page"),), // TODO : Resources Page
    const Center(child: Text("3rd Page"),), // TODO: Chat Page
    // const ProfileScreen(), // Profile Page
  ];

  @override
  Widget build(BuildContext context) {
    final double textFontSize = 14;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: textFontSize,
        unselectedFontSize: textFontSize,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: "Resources",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat),
            label: "Chat",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_outline),
          //   activeIcon: Icon(Icons.person),
          //   label: "Profile",
          // ),
        ],
      ),
    );
  }
}

// data - repository
// domain - 
// presentation - controller, screens, widgets
