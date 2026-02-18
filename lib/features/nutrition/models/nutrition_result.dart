import 'dart:convert';

class NutritionResult {
  final String foodName;
  final bool isFood;
  final List<String> ingredients;
  final String portionSize;
  final NutritionalData nutrition;
  final String description;

  NutritionResult({
    required this.foodName,
    required this.isFood,
    required this.ingredients,
    required this.portionSize,
    required this.nutrition,
    required this.description,
  });

  factory NutritionResult.fromJson(Map<String, dynamic> json) {
    return NutritionResult(
      foodName: json['food_name'] ?? 'Unknown',
      isFood: json['is_food'] ?? false,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      portionSize: json['portion_size'] ?? 'Unknown',
      nutrition: NutritionalData.fromJson(json['nutrition'] ?? {}),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'food_name': foodName,
    'is_food': isFood,
    'ingredients': ingredients,
    'portion_size': portionSize,
    'nutrition': nutrition.toJson(),
    'description': description,
  };
}

class NutritionalData {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;

  NutritionalData({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
  });

  factory NutritionalData.fromJson(Map<String, dynamic> json) {
    return NutritionalData(
      calories: (json['calories'] ?? 0).toDouble(),
      protein: (json['protein'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
      fat: (json['fat'] ?? 0).toDouble(),
      fiber: (json['fiber'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'fiber': fiber,
  };
}
