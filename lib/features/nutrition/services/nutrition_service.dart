import 'dart:convert';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:kitahack_2026/features/nutrition/models/nutrition_result.dart';

class NutritionService {
  final String apiKey;
  late final GenerativeModel _model;

  NutritionService({required this.apiKey}) {
    _model = GenerativeModel(
      model: 'gemini-3-flash-preview',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
      ),
    );
  }

  Future<NutritionResult> analyzeFoodImage(Uint8List imageBytes) async {
    final prompt = '''
      You are a specialized multi-agent system for food analysis. 
      Act as three specialized agents working together:
      1. Classifier Agent: Determine if the image contains a food item.
      2. Ingredient Agent: Identify all ingredients and the dish name.
      3. Nutritionist Agent: Estimate portion sizes and calculate detailed nutritional data (calories, protein, carbs, fat, fiber).

      Analyze the provided image and return a JSON object with the following structure:
      {
        "is_food": boolean,
        "food_name": "string",
        "ingredients": ["string"],
        "portion_size": "string",
        "nutrition": {
          "calories": number,
          "protein": number,
          "carbs": number,
          "fat": number,
          "fiber": number
        },
        "description": "string (a brief summary of the analysis)"
      }

      If it is not a food item, set "is_food" to false and provide a description explaining why.
    ''';

    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageBytes),
      ])
    ];

    try {
      final response = await _model.generateContent(content);
      final responseText = response.text;
      
      if (responseText == null) {
        throw Exception('No response from Gemini');
      }

      final jsonResponse = jsonDecode(responseText);
      return NutritionResult.fromJson(jsonResponse);
    } catch (e) {
      print('Error analyzing image: $e');
      rethrow;
    }
  }
}
