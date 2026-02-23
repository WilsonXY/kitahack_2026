import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/features/auth/data/auth_providers.dart';
import 'package:kitahack_2026/features/auth/models/user_model.dart';

final completeProfileViewModelProvider =
    AsyncNotifierProvider<CompleteProfileViewModel, void>(CompleteProfileViewModel.new);

class CompleteProfileViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> selectRole(String name) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async { // Direct to MainWrapper page after selected Role and input Name
      final auth = ref.read(firebaseAuthProvider);
      final repository = ref.read(userRepositoryProvider);

      final currentUser = auth.currentUser;
      if (currentUser == null) throw Exception("No user logged in");

      final newUser = UserModel(
        uid: currentUser.uid,
        name: name,
        email: currentUser.email ?? '',
        createdAt: DateTime.now(),
      );

      await repository.saveUserData(newUser);
    });
  }
}
