import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitahack_2026/features/nutrition/models/nutrition_result.dart';

class FoodModel {
  final String? id; // Nullable since Firebase creates id automatically
  final String userId;
  final String imageUrl;
  final DateTime createdAt;
  final NutritionResult nutritionResult;

  FoodModel({
    this.id,
    required this.userId,
    required this.imageUrl,
    required this.createdAt,
    required this.nutritionResult,
  });

  // Converts data into Firebase readable format
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'nutritionResult': nutritionResult.toJson(),
    };
  }

  // Parses data from Firestore
  factory FoodModel.fromMap(Map<String, dynamic> map, String documentId) {
    return FoodModel(
      id: documentId,
      userId: map['userId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      nutritionResult: NutritionResult.fromJson(map['nutritionResult'] ?? {}),
    );
  }
}
