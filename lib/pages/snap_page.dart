import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';

class SnapPage extends StatefulWidget {
  const SnapPage({super.key});

  @override
  State<SnapPage> createState() => _SnapPageState();
}

class _SnapPageState extends State<SnapPage> with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _useCamera = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _initCamera() async {
    setState(() {
      _useCamera = true;
    });
    final cameras = await availableCameras();
    final CameraDescription camera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() => _isCameraInitialized = true);
      }
    } catch (e) {
      debugPrint("Camera error: $e");
      if (mounted) {
        setState(() {
          _useCamera = false;
          _isCameraInitialized = false;
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized || _controller == null) return;

    try {
      final XFile image = await _controller!.takePicture();
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/result', arguments: image.path);
    } catch (e) {
      debugPrint("Error taking picture: $e");
    }
  }

  Future<void> _pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null && mounted) {
        Navigator.pushReplacementNamed(context, '/result', arguments: image.path);
      }
    } catch (e) {
      debugPrint("Gallery error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_useCamera) {
      return _buildSelectionScreen();
    }

    if (!_isCameraInitialized || _controller == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: kMangoPrimary)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            setState(() {
              _useCamera = false;
              _controller?.dispose();
              _controller = null;
              _isCameraInitialized = false;
            });
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: CameraPreview(_controller!),
          ),
          _buildCameraOverlay(),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kMangoPrimary, width: 2),
                    color: Colors.transparent,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: _takePicture,
                    splashColor: kMangoPrimary,
                    child: Container(
                      width: 90,
                      height: 90,
                      padding: const EdgeInsets.all(4),
                      child: const CircleAvatar(
                        backgroundColor: kMangoPrimary,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionScreen() {
    return Scaffold(
      backgroundColor: kMangoBackground,
      appBar: AppBar(
        title: const Text('Capture Image', style: TextStyle(color: kTextBrown, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextBrown),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.photo_camera_rounded, size: 100, color: kMangoPrimary),
            const SizedBox(height: 40),
            const Text(
              'How would you like to add your food?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kTextBrown),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _initCamera,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take a Photo', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: kMangoPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _pickFromGallery,
              icon: const Icon(Icons.photo_library),
              label: const Text('Upload from Gallery', style: TextStyle(fontSize: 18)),
              style: OutlinedButton.styleFrom(
                foregroundColor: kMangoPrimary,
                side: const BorderSide(color: kMangoPrimary, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraOverlay() {
    return Stack(
      children: [
        Positioned(
          top: 130,
          left: 40,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kMangoAccent, width: 3),
                left: BorderSide(color: kMangoAccent, width: 3),
              ),
            ),
          ),
        ),
        Positioned(
          top: 130,
          right: 40,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kMangoAccent, width: 3),
                right: BorderSide(color: kMangoAccent, width: 3),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 250,
          left: 40,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: kMangoAccent, width: 3),
                left: BorderSide(color: kMangoAccent, width: 3),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 250,
          right: 40,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: kMangoAccent, width: 3),
                right: BorderSide(color: kMangoAccent, width: 3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
