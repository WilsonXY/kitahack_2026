import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/core/navigation/main_wrapper.dart';
import 'package:kitahack_2026/features/auth/presentation/screens/complete_profile_screen.dart';
import 'package:kitahack_2026/features/auth/presentation/viewmodel/auth_viewmodel.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (firebaseUser) {
        // Case 1 : Not logged in to Firebase
        if (firebaseUser == null) {
          return SignInScreen(providers: [EmailAuthProvider()]);
        }

        // Case 2 : Logged Into Firebase and Now Watch for Firestore Data
        final userModelAsync = ref.watch(userModelProvider);

        return userModelAsync.when(
          data: (userModel){
            // Case 3: Logged in, but no Firestore document exists yet
            if (userModel == null) {
              return const CompleteProfileScreen();
            }

            // Case 4 : Logged in and have Firestore Document
            else {
              return const MainWrapper();
            }
          },
          error: (error, stack) =>
              Scaffold(body: Center(child: Text("DB Error: $error"))),
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
      error: (error, stack) =>
          Scaffold(body: Center(child: Text("Error : $error"))),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
