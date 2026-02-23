import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/features/auth/data/auth_providers.dart';
import 'package:kitahack_2026/features/auth/models/user_model.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final userModelProvider = FutureProvider<UserModel?>((ref) async {
  final authState = ref.watch(authStateProvider);
  final firebaseUser = authState.value;

  if(firebaseUser == null) return null;

  final repository = ref.watch(userRepositoryProvider);
  return await repository.getUser(firebaseUser.uid);
});