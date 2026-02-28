import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/features/auth/data/auth_providers.dart';
import 'package:kitahack_2026/features/nutrition/data/food_provider.dart';
import 'package:kitahack_2026/features/nutrition/models/food_model.dart';
import 'package:kitahack_2026/features/nutrition/models/nutrition_result.dart';

final foodViewModelProvider =
    AsyncNotifierProvider<FoodViewModel, void>(FoodViewModel.new);

class FoodViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> saveFood(NutritionResult nutritionResult, DateTime? createdAt) async { // TODO : Add Uint8List imageBytes, 
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final auth = ref.read(firebaseAuthProvider);
      final repository = ref.read(foodRepositoryProvider);

      final currentUser = auth.currentUser;
      if (currentUser == null) throw Exception("No user logged in");

      // TODO : Wait for Nicholas
      // final String uploadedImageUrl = await repository.uploadFoodImage(currentUser.uid, imageBytes);

      final newFood = FoodModel(
        userId: currentUser.uid,
        imageUrl: "",
        createdAt: createdAt ?? DateTime.now(),
        nutritionResult: nutritionResult,
      );

      await repository.saveFood(newFood);

      ref.invalidate(foodHistoryProvider);
    });
  }
}
