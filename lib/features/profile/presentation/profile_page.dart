// Mock Design

import 'package:firebase_auth/firebase_auth.dart'; // Import this
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          // Sign-Out Button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 2. Display the email safely
            Text("Hi, ${user?.email ?? 'User'}!"),
            const SizedBox(height: 10),
            Text("UID: ${user?.uid}"), // Useful for debugging
          ],
        ),
      ),
    );
  }
}