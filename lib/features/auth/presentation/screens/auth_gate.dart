import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/core/navigation/main_wrapper.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/features/auth/presentation/screens/complete_profile_screen.dart';
import 'package:kitahack_2026/features/auth/presentation/screens/splash_screen.dart';
import 'package:kitahack_2026/features/auth/presentation/viewmodel/auth_viewmodel.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _hideSplash();
  }

  Future<void> _hideSplash() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return const SplashScreen();
    }

    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (firebaseUser) {
        if (firebaseUser == null) {
          return Theme(
            data: Theme.of(context).copyWith(
              scaffoldBackgroundColor: kMangoBackground,
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.black),
                bodyLarge: TextStyle(color: Colors.black),
                titleLarge: TextStyle(color: Colors.black),
              ),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: const TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kMangoPrimary, width: 2),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMangoPrimary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            child: ui.SignInScreen(
              providers: [ui.EmailAuthProvider()],
              headerBuilder: (context, constraints, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: kMangoPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, size: 60, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          );
        }

        final userModelAsync = ref.watch(userModelProvider);

        return userModelAsync.when(
          data: (userModel) {
            if (userModel == null) {
              return const CompleteProfileScreen();
            } else {
              return const MainWrapper();
            }
          },
          error: (error, stack) => Scaffold(body: Center(child: Text("DB Error: $error"))),
          loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(color: kMangoPrimary))),
        );
      },
      error: (error, stack) => Scaffold(body: Center(child: Text("Error : $error"))),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(color: kMangoPrimary))),
    );
  }
}
