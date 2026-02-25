// Unused -> Change to Bottom Navigation Bar Design

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';

class SnapMangoDrawer extends StatelessWidget {
  const SnapMangoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kMangoBackground,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: kMangoPrimary,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
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
                      'Welcome Back!',
                      style: TextStyle(
                        color: kMangoBackground,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),

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

            const Spacer(),

            _buildDrawerItem(
              context: context,
              icon: Icons.logout,
              title: 'Logout',
              onTap: () async {
                // close drawer first
                Navigator.pop(context);
                // sign out
                await FirebaseAuth.instance.signOut();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? routeName,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: kMangoPrimary.withOpacity(0.2),
        highlightColor: kMangoAccent.withOpacity(0.1),
        onTap: () {
          Future.delayed(const Duration(milliseconds: 100), () async {
            if (!context.mounted) return;
            if (onTap != null) {
              onTap();
              return;
            }
            Navigator.pop(context);
            if (routeName != null && routeName.isNotEmpty) {
              Navigator.pushNamed(context, routeName);
            }
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
