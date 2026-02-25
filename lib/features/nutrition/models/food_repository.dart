import 'dart:typed_data';

import 'package:kitahack_2026/features/nutrition/models/food_model.dart';
import 'package:kitahack_2026/features/nutrition/models/food_services.dart';

class FoodRepository {
  final FoodServices foodServices;

  FoodRepository(this.foodServices);

  Future<void> saveFood(FoodModel foods) async {
    try {
      await foodServices.saveFood(foods.userId, foods.toMap());
    } catch (e) {
      throw Exception('Failed to Save Foods Data: $e');
    }
  }

  Future<List<FoodModel>> getAllFood(String uid) async {
    try {
      final snapshot = await foodServices.getUserFood(uid);

      return snapshot.docs.map((doc){
        return FoodModel.fromMap(doc.data() as Map<String,dynamic>,doc.id);
      }).toList();
    } catch (e){
      throw Exception('Failed to Get Foods');
    }
  }
}
