import 'package:kitahack_2026/features/nutrition/models/food_model.dart';
import 'package:kitahack_2026/features/nutrition/models/food_services.dart';

class FoodRepository {
  final FoodServices foodServices;

  FoodRepository(this.foodServices);

  Future<void> saveFood(FoodModel foods) async {
    try {
      await foodServices.saveFood(foods.userId, foods.toMap());
    } catch (e) {
      throw Exception('Failed to Save User Data: $e');
    }
  }
}
