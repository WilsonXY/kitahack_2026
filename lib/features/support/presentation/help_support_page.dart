import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/core/theme/sizes.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMangoBackground,
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.bold, color: kTextBrown),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextBrown),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Frequently Asked Questions"),
            const SizedBox(height: 12),
            _buildFAQTile(
              "How do I track my calories?",
              "Simply tap the 'Snap!' button on the home screen and take a photo of your food. Our AI will analyze the ingredients and estimate the calories for you.",
            ),
            _buildFAQTile(
              "How accurate is the AI analysis?",
              "Our AI uses advanced multi-agent systems to identify food items and estimate portions. While highly accurate, we recommend using it as a guide and adjusting portions if necessary.",
            ),
            _buildFAQTile(
              "Can I use images from my gallery?",
              "Yes! On the snap screen, you can choose to upload an existing photo from your gallery instead of taking a new one.",
            ),
            _buildFAQTile(
              "Is my data private?",
              "Absolutely. We value your privacy and ensure that your food logs and profile information are stored securely.",
            ),
            const SizedBox(height: 32),
            _buildSectionTitle("Contact Us"),
            const SizedBox(height: 12),
            _buildContactTile(
              Icons.email_outlined,
              "Email Support",
              "support@snapmango.com",
              () {},
            ),
            _buildContactTile(
              Icons.chat_bubble_outline_rounded,
              "Live Chat",
              "Available 9 AM - 6 PM",
              () {},
            ),
            _buildContactTile(
              Icons.language_rounded,
              "Visit Website",
              "www.snapmango.com",
              () {},
            ),
            const SizedBox(height: 32),
            _buildSectionTitle("App Information"),
            const SizedBox(height: 12),
            _buildInfoCard("Version", "1.0.0 (Build 2026)"),
            _buildInfoCard("Terms of Service", "Read our terms"),
            _buildInfoCard("Privacy Policy", "Read our policy"),
            const SizedBox(height: 40),
            Center(
              child: Text(
                "© 2026 SnapMango Inc.",
                style: TextStyle(
                  color: kTextBrown.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: kTextBrown,
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kMangoAccent.withValues(alpha: 0.2)),
      ),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: kTextBrown,
            fontSize: 15,
          ),
        ),
        iconColor: kMangoPrimary,
        collapsedIconColor: kMangoPrimary,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                color: kTextBrown.withValues(alpha: 0.7),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(
      IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kMangoAccent.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kMangoPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: kMangoPrimary, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: kTextBrown,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: kTextBrown.withValues(alpha: 0.6),
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: kTextBrown, size: 20),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: kTextBrown.withValues(alpha: 0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: kTextBrown,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
