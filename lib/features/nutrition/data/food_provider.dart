import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/features/nutrition/models/food_repository.dart';
import 'package:kitahack_2026/features/nutrition/models/food_services.dart';

final foodServiceProvider = Provider((ref){
  return FoodServices();
});

final foodRepositoryProvider= Provider((ref){
  final service = ref.watch(foodServiceProvider);
  return FoodRepository(service);
});