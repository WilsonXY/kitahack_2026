import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';

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
      // TODO: camera implementation here, this is placeholder
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.grey[850],
              child: const Center(
                child: Text(
                  'Camera Preview',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 40,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: kMangoAccent, width: 3),
                  left: BorderSide(color: kMangoAccent, width: 3),
                ),
              ),
            ),
          ),
          Positioned(
            top: 130,
            right: 40,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: kMangoAccent, width: 3),
                  right: BorderSide(color: kMangoAccent, width: 3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 250,
            left: 40,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: kMangoAccent, width: 3),
                  left: BorderSide(color: kMangoAccent, width: 3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 250,
            right: 40,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: kMangoAccent, width: 3),
                  right: BorderSide(color: kMangoAccent, width: 3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
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
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: const Text(
                          'Gallery',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
