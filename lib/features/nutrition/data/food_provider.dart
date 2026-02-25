import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/features/auth/data/auth_providers.dart';
import 'package:kitahack_2026/features/nutrition/models/food_model.dart';
import 'package:kitahack_2026/features/nutrition/models/food_repository.dart';
import 'package:kitahack_2026/features/nutrition/models/food_services.dart';

final foodServiceProvider = Provider((ref) {
  return FoodServices();
});

final foodRepositoryProvider = Provider((ref) {
  final service = ref.watch(foodServiceProvider);
  return FoodRepository(service);
});

final foodHistoryProvider = FutureProvider.autoDispose<List<FoodModel>>((
  ref,
) async {
  final auth = ref.watch(firebaseAuthProvider);
  final user = auth.currentUser;

  if (user == null) return [];

  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getAllFood(user.uid);
});
