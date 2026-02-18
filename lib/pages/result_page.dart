import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/widgets/social_icon.dart';
import 'package:kitahack_2026/features/nutrition/models/nutrition_result.dart';
import 'package:kitahack_2026/features/nutrition/services/nutrition_service.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
        foregroundColor: kTextBrown,
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
            style: TextStyle(color: kTextBrown, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Our AI agents are working together...', style: TextStyle(color: Colors.grey)),
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
            Text(_error!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResultState() {
    if (_result == null) return const SizedBox.shrink();

    final jsonString = const JsonEncoder.withIndent('  ').convert(_result!.toJson());

    return Padding(
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
                  )
                ]),
            child: _imageBytes == null
                ? const Icon(Icons.fastfood, size: 80, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 20),
          Text(
            _result!.isFood ? _result!.foodName : 'Not Food Identified',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextBrown),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kMangoAccent.withValues(alpha: 0.5)),
              ),
              child: SingleChildScrollView(
                child: Text(
                  jsonString,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    color: kTextBrown,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                  ),
                  icon: const Icon(Icons.share),
                  label: const Text('Share', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 16),
              _buildIconButton(Icons.download, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Saving to device..."),
                    backgroundColor: kMangoPrimary,
                    duration: Duration(milliseconds: 500),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
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
                  decoration: BoxDecoration(color: kPlaceholderGrey, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              const Text('Share Result',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextBrown)),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kMangoPrimary, width: 2),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: kPlaceholderGrey),
                        SizedBox(height: 10),
                        Text('(Generated Report Image)',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kTextBrown, fontWeight: FontWeight.w500)),
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
