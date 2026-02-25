import 'package:flutter/material.dart';
// import 'package:kitahack_2026/core/theme/mango_theme.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const SocialIcon(this.icon, this.color, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
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
          onTap: onTap,
          child: Center(
            child: Icon(icon, color: color, size: 30),
          ),
        ),
      ),
    );
  }
}
