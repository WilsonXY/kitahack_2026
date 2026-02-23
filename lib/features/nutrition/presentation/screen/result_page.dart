import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/features/nutrition/presentation/viewmodel/result_viewmodel.dart';
import 'package:kitahack_2026/widgets/social_icon.dart';
import 'package:kitahack_2026/features/nutrition/models/nutrition_result.dart';
import 'package:kitahack_2026/features/nutrition/services/nutrition_service.dart';

class ResultPage extends ConsumerStatefulWidget {
  const ResultPage({super.key});

  @override
  ConsumerState<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends ConsumerState<ResultPage> {
  late NutritionService _nutritionService;
  NutritionResult? _result;
  bool _isLoading = true;
  String? _error;
  String? _imagePath;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _nutritionService = NutritionService(apiKey: apiKey);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_imagePath == null) {
      _imagePath = ModalRoute.of(context)!.settings.arguments as String?;
      if (_imagePath != null) {
        _analyzeImage(_imagePath!);
      } else {
        setState(() {
          _isLoading = false;
          _error = 'No image provided';
        });
      }
    }
  }

  Future<void> _analyzeImage(String path) async {
    try {
      final XFile file = XFile(path);
      final bytes = await file.readAsBytes();

      setState(() {
        _imageBytes = bytes;
      });

      final result = await _nutritionService.analyzeFoodImage(bytes);
      setState(() {
        _result = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to analyze image: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Result'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // foregroundColor: kTextBrown,
      ),
      body: _isLoading
          ? _buildLoadingState()
          : _error != null
          ? _buildErrorState()
          : _buildResultState(),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: kMangoPrimary),
          const SizedBox(height: 20),
          Text(
            'Analyzing your food...',
            style: TextStyle(
              // color: kTextBrown,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Our AI agents are working together...',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultState() {
    if (_result == null) return const SizedBox.shrink();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: kPlaceholderGrey,
              borderRadius: BorderRadius.circular(12),
              image: _imageBytes != null
                  ? DecorationImage(
                      image: MemoryImage(_imageBytes!),
                      fit: BoxFit.cover,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: _imageBytes == null
                ? const Icon(Icons.fastfood, size: 80, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 24),
          Text(
            _result!.isFood ? _result!.foodName : 'Not Food Identified',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              //color: kTextBrown,
            ),
          ),
          if (_result!.isFood) ...[
            const SizedBox(height: 12),
            Text(
              _result!.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                // color: kTextBrown.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 32),
            _buildNutritionGrid(),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kMangoAccent.withValues(alpha: 0.3)),
              ),
              child: _buildInfoRow(
                  Icons.scale, 'Portion Size', _result!.portionSize),
            ),
            const SizedBox(height: 24),
            if (_result!.ingredients.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    //color: kTextBrown,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _result!.ingredients.map((ingredient) {
                  return Chip(
                    label: Text(ingredient),
                    backgroundColor: kMangoPrimary.withValues(alpha: 0.1),
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w500),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  );
                }).toList(),
              ),
              )
            ],
          ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: _result!.isFood
                ? Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showSharePopOut(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kMangoPrimary,
                            foregroundColor: kMangoBackground,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          icon: const Icon(Icons.share),
                          label: const Text(
                            'Share',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildIconButton(Icons.download, _saveFood),
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kMangoPrimary,
                        foregroundColor: kMangoBackground,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      icon: const Icon(Icons.home),
                      label: const Text(
                        'Back to Home',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionGrid() {
    final nutrition = _result!.nutrition;
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

  Widget _buildMacroRow(
      String label, String value, IconData icon, Color color) {
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kTextBrown,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kTextBrown,
          ),
        ),
      ],
    );
  }

  Widget _buildMacroItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: kTextBrown,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: kTextBrown.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
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
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: kTextBrown.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kTextBrown,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _saveFood() async {
    ref.read(foodViewModelProvider.notifier).saveFood(_result!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Saving to device..."),
        backgroundColor: kMangoPrimary,
        duration: Duration(milliseconds: 500),
      ),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kMangoPrimary, width: 2),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: kMangoPrimary.withValues(alpha: 0.2),
          onTap: onTap,
          child: Center(child: Icon(icon, color: kMangoPrimary, size: 28)),
        ),
      ),
    );
  }

  void _showSharePopOut(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kMangoBackground,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 6,
                decoration: BoxDecoration(
                  color: kPlaceholderGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Share Result',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  // color: kTextBrown,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kMangoPrimary, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: kPlaceholderGrey),
                        SizedBox(height: 10),
                        Text(
                          '(Generated Report Image)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: kTextBrown,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialIcon(Icons.facebook, Colors.blue),
                  SocialIcon(Icons.alternate_email, Colors.black),
                  SocialIcon(Icons.message, Colors.green),
                  SocialIcon(Icons.more_horiz, kMangoPrimary),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
