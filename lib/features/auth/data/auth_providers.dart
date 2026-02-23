import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/features/auth/models/user_repository.dart';
import 'package:kitahack_2026/features/auth/models/user_services.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref){
  return FirebaseAuth.instance;
});

final userServiceProvider = Provider<UserServices>((ref){
  return UserServices();
});

final userRepositoryProvider = Provider<UserRepository>((ref){
  final service = ref.watch(userServiceProvider);
  return UserRepository(service);
});