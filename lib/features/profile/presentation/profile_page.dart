import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/core/theme/sizes.dart';
import 'package:kitahack_2026/features/auth/data/auth_providers.dart';
import 'package:kitahack_2026/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:kitahack_2026/features/nutrition/data/food_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  void _showSettingsModal(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kMangoBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: kTextBrown.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTextBrown,
              ),
            ),
            const SizedBox(height: 20),
            _buildMenuTile(Icons.edit_outlined, "Edit Profile", () {}),
            _buildMenuTile(Icons.notifications_none_rounded, "Notifications", () {}),
            _buildMenuTile(Icons.security_outlined, "Privacy & Security", () {}),
            _buildMenuTile(Icons.help_outline_rounded, "Help & Support", () {}),
            const Divider(height: 32),
            _buildMenuTile(
              Icons.logout_rounded,
              "Logout",
              () {
                Navigator.pop(context);
                ref.read(firebaseAuthProvider).signOut();
              },
              isDestructive: true,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userModelProvider);
    final historyAsync = ref.watch(foodHistoryProvider);

    return Scaffold(
      backgroundColor: kMangoBackground,
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold, color: kTextBrown)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: kTextBrown),
            onPressed: () => _showSettingsModal(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            // Profile Header Section
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kMangoPrimary, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 60, color: kMangoPrimary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  userAsync.when(
                    data: (user) => Column(
                      children: [
                        Text(
                          user?.name ?? "Mango User",
                          style: const TextStyle(
                            color: kTextBrown,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user?.email ?? "",
                          style: TextStyle(
                            color: kTextBrown.withValues(alpha: 0.6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    loading: () => const CircularProgressIndicator(color: kMangoPrimary),
                    error: (_, __) => const Text("Error loading profile", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Stats Cards
            _buildSectionTitle("Activity Summary"),
            const SizedBox(height: 12),
            historyAsync.when(
              data: (foods) {
                final totalCalories = foods.fold(0.0, (sum, item) => sum + item.nutritionResult.nutrition.calories);
                return Row(
                  children: [
                    Expanded(child: _buildStatCard("Logs", "${foods.length}", Icons.restaurant_menu, Colors.orange)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard("Total kcal", totalCalories.toStringAsFixed(0), Icons.local_fire_department, Colors.red)),
                  ],
                );
              },
              loading: () => const SizedBox(height: 80, child: Center(child: CircularProgressIndicator(color: kMangoPrimary))),
              error: (_, __) => const SizedBox(height: 80, child: Center(child: Text("Error loading stats"))),
            ),
            const SizedBox(height: 24),

            // Daily Goals Section
            _buildSectionTitle("Daily Goals"),
            const SizedBox(height: 12),
            _buildGoalProgress("Calories", 0.65, "1,300 / 2,000 kcal"),
            _buildGoalProgress("Water", 0.4, "3 / 8 glasses"),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kTextBrown,
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kMangoAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kTextBrown)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    final color = isDestructive ? Colors.red : kMangoPrimary;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDestructive ? Colors.red.withValues(alpha: 0.2) : kMangoAccent.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.red : kTextBrown,
            fontSize: 15,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: isDestructive ? Colors.red : kTextBrown,
          size: 20,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildGoalProgress(String label, double progress, String detail) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kMangoAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: kTextBrown)),
              Text(detail, style: TextStyle(fontSize: 12, color: kTextBrown.withValues(alpha: 0.6), fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: kMangoPrimary.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(kMangoPrimary),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
