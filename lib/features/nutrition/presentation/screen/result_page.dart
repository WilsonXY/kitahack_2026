import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/features/nutrition/presentation/viewmodel/result_viewmodel.dart';
import 'package:kitahack_2026/features/nutrition/presentation/widgets/social_icon.dart';
import 'package:kitahack_2026/features/nutrition/models/nutrition_result.dart';
import 'package:kitahack_2026/features/nutrition/services/nutrition_service.dart';

//import 'dart:ui' as ui;
//import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:flutter/foundation.dart';
import 'package:file_saver/file_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:intl/intl.dart';
//import 'package:kitahack_2026/features/nutrition/services/sharing_services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final ScreenshotController _screenshotController = ScreenshotController(); 
  bool _isSavingImage = false;
  DateTime? _analysisCreatedAt;
  Uint8List? _exportImageBytes;

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted && _imageBytes != null) {
        _captureExportImage();
      }
    });


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
                            _showSharePopOut(context, _exportImageBytes);
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

  Widget _buildMacroItem(String label, String value, Color color, {bool isExport = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isExport ? 16 : 18,
            fontWeight: FontWeight.bold,
            color: kTextBrown,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: isExport ? 12 : 14,
            color: kTextBrown.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: isExport ? 24 : 40,
          height: 3,
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
    if (_isSavingImage || _result == null) return;
    
    setState(() => _isSavingImage = true);

      try{
        if(_exportImageBytes == null){
          await _captureExportImage();
        }
    
      final cleanFoodName = _result!.foodName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      final fileName = "${cleanFoodName}_nutrition_report";

      if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
        final hasAccess = await Gal.hasAccess();
        if (!hasAccess) await Gal.requestAccess();
        await Gal.putImageBytes(_exportImageBytes!, name: fileName);

      } else {
        await FileSaver.instance.saveFile(
          name: fileName,
          bytes: _exportImageBytes,
          fileExtension: 'png',
          mimeType: MimeType.png,
        );
      }

      _analysisCreatedAt = DateTime.now();
      await ref.read(foodViewModelProvider.notifier).saveFood(_result!, _analysisCreatedAt);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image Saved to Device."), backgroundColor: kMangoPrimary),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSavingImage = false);
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    }
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

  void _showSharePopOut(BuildContext context, Uint8List? exportImageBytes) {
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
          height: MediaQuery.of(context).size.height * 0.72,
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
                  alignment: Alignment.center,
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
                  child: exportImageBytes != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.memory(
                            exportImageBytes,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox.expand(),

                  // child: const Center(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(Icons.image, size: 50, color: kPlaceholderGrey),
                  //       SizedBox(height: 10),
                  //       Text(
                  //         '(Generated Report Image)',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //           // color: kTextBrown,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //    ],
                  //  ),
                  //),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialIcon(
                    Icons.facebook, 
                    Colors.blue, 
                    onTap: _shareToFacebook,
                    ),
                  SocialIcon(
                    Icons.alternate_email, 
                    Colors.black,
                    onTap: _shareToGmail,
                    ),
                  SocialIcon(Icons.message, Colors.green),
                  SocialIcon(
                    Icons.more_horiz, 
                    kMangoPrimary,
                    onTap: _shareToSelection
                    ,),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _shareToFacebook() async {
  // Just redirects to FB
  try {
    final facebookUrl = Uri.parse('https://www.facebook.com/');
    await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open Facebook: $e'), backgroundColor: Colors.red),
      );
    }
  }
}

  Future<void> _shareToGmail() async {
  if (_exportImageBytes == null) return;

  try {
    final subject = '${_result!.foodName} - Nutrition Analysis';
    final body = 'Check out my food analysis from SnapMango 2026!\n\nFood: ${_result!.foodName}\nPortion: ${_result!.portionSize}';

    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
      // Mobile
      final sharingContent = ShareParams(
        text: body,
        subject: subject,
        files: [XFile.fromData(
          _exportImageBytes!,
          mimeType: 'image/png',
          name: 'nutrition_report.png',
        )],
      );
      
      await SharePlus.instance.share(sharingContent);
    } else {
      // Web/PC
      final encodedSubject = Uri.encodeComponent(subject);
      final encodedBody = Uri.encodeComponent(body);
      
      final gmailUrl = Uri.parse('https://mail.google.com/mail/?view=cm&fs=1&to=&su=$encodedSubject&body=$encodedBody');
      await launchUrl(gmailUrl, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open Gmail: $e'), backgroundColor: Colors.red),
      );
    }
  }
}


  // NOTE: Doesn't work on pc yet
  Future<void> _shareToSelection() async {
  try {
    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
      // Mobile
      final sharingContent = ShareParams(
        text: '${_result!.foodName} - Nutrition Analysis\n\nGenerated by SnapMango 2026',
        files: [XFile.fromData(
          _exportImageBytes!,
          mimeType: 'image/png',
          name: 'nutrition_report.png',
        )],
      );
      
      
    } else {
      // Web/PC
      final sharingContent = ShareParams(
        text: '${_result!.foodName} - Nutrition Analysis\n\nGenerated by SnapMango 2026',
        files: [XFile.fromData(
          _exportImageBytes!,
          mimeType: 'image/png',
          name: 'nutrition_report.png',
        )],
      );await SharePlus.instance.share(sharingContent);
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share: $e'), backgroundColor: Colors.red),
      );
    }
  }
}


  Widget _buildExportImage() {
    final String formattedDate = DateFormat('MMM d, yyyy • h:mm a').format(_analysisCreatedAt ?? DateTime.now());

    return Material(
      color: kMangoBackground,
      child: Container(
        width: 540,
        height: 600,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Text(
            //   "My Food Analysis",
            //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: kMangoPrimary),
            // ),
            // const SizedBox(height: 16),

            // Polaroid Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(2, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Polaroid Image Section
                  Container(
                    width: 280,
                    height: 280,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: kMangoPrimary,
                        width: 8,
                      ),
                      image: _imageBytes != null 
                          ? DecorationImage(image: MemoryImage(_imageBytes!), fit: BoxFit.cover)
                          : null,
                    ),
                  ),

                  // Polaroid Bottom Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Food Name
                        Text(
                          _result!.foodName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kTextBrown,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Portion Size
                        Text(
                          "Portion: ${_result!.portionSize}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Nutrition Info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _buildMacroItem('Calories', '${_result!.nutrition.calories.round()}', Colors.orange, isExport: true)),
                            Expanded(child: _buildMacroItem('Protein', '${_result!.nutrition.protein}g', Colors.blue, isExport: true)),
                            Expanded(child: _buildMacroItem('Carbs', '${_result!.nutrition.carbs}g', Colors.green, isExport: true)),
                            Expanded(child: _buildMacroItem('Fat', '${_result!.nutrition.fat}g', Colors.red, isExport: true)),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Date + time created
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: kMangoPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Text("Generated by SnapMango 2026", style: TextStyle(fontSize: 9, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // Helper for _saveFood and in showSharePopUp
  Future<void> _captureExportImage() async {
    _exportImageBytes = await _screenshotController.captureFromWidget(
      _buildExportImage(),
      delay: const Duration(milliseconds: 100),
      pixelRatio: 2.0,
      context: context,
    );
  }
}
