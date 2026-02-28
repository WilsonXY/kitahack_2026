import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/core/theme/sizes.dart';
import 'package:kitahack_2026/features/nutrition/models/food_model.dart';
import 'package:intl/intl.dart';

class HistoryDetailPage extends StatelessWidget {
  final FoodModel foodModel;

  const HistoryDetailPage({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context) {
    final result = foodModel.nutritionResult;
    final String formattedDate = DateFormat('MMM d, yyyy • h:mm a').format(foodModel.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Food Image Placeholder or actual image
            if (foodModel.imageUrl.isNotEmpty)
               Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(foodModel.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: kPlaceholderGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.fastfood, size: 80, color: Colors.white),
              ),

            // Title and Date
            Text(
              result.foodName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            kGap8,
            Text(
              formattedDate,
              style: TextStyle(fontSize: 14, color: kTextBrown.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 20),
            
            // Description
            if (result.description.isNotEmpty) ...[
              Text(
                result.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 32),
            ],

            // Nutrition Grid
            _buildNutritionGrid(result.nutrition),
            const SizedBox(height: 24),

            // Portion Size
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildInfoRow(Icons.scale, 'Portion Size', result.portionSize),
            ),
            const SizedBox(height: 24),

            // Ingredients Chips
            if (result.ingredients.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: result.ingredients.map((ingredient) {
                    return Chip(
                      label: Text(ingredient),
                      backgroundColor: kMangoPrimary.withValues(alpha: 0.1),
                      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    );
                  }).toList(),
                ),
              )
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionGrid(dynamic nutrition) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMacroRow('Calories', '${nutrition.calories.round()} kcal',
              Icons.local_fire_department, Colors.orange),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMacroItem('Protein', '${nutrition.protein}g', Colors.blue),
              _buildMacroItem('Carbs', '${nutrition.carbs}g', Colors.green),
              _buildMacroItem('Fat', '${nutrition.fat}g', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroRow(String label, String value, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: kTextBrown),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kTextBrown),
        ),
      ],
    );
  }

  Widget _buildMacroItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextBrown)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: kTextBrown.withValues(alpha: 0.6))),
        const SizedBox(height: 8),
        Container(
          width: 40, height: 4,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kMangoPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: kMangoPrimary, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 13, color: kTextBrown.withValues(alpha: 0.6), fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: kTextBrown)),
            ],
          ),
        ),
      ],
    );
  }
}
