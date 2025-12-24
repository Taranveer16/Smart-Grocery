import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ReceiptScanScreen extends StatefulWidget {
  const ReceiptScanScreen({super.key});

  @override
  State<ReceiptScanScreen> createState() => _ReceiptScanScreenState();
}

class _ReceiptScanScreenState extends State<ReceiptScanScreen> {
  File? _image;
  String _extractedText = '';
  List<Map<String, dynamic>> _parsedItems = [];
  bool _isProcessing = false;

  final ImagePicker _picker = ImagePicker();
  final textRecognizer = GoogleMlKit.vision.textRecognizer();

  // Pick image from camera
  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _extractedText = '';
        _parsedItems = [];
      });
      await _extractText();
    }
  }

  // Extract text using ML Kit
  Future<void> _extractText() async {
    if (_image == null) return;

    setState(() => _isProcessing = true);

    final inputImage = InputImage.fromFile(_image!);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    setState(() {
      _extractedText = text;
    });

    await _parseItems(text);
    await _storeInFirestore();

    setState(() => _isProcessing = false);
  }

  // Parse items (customize regex based on receipt format)
  Future<void> _parseItems(String text) async {
    // Simple regex: Assumes lines like "ItemName Qty $Price" or similar
    final RegExp pattern = RegExp(r'([a-zA-Z\s]+)\s+(\d+)\s+\$?(\d+\.?\d{2})', multiLine: true);
    final matches = pattern.allMatches(text);

    List<Map<String, dynamic>> items = [];
    for (final match in matches) {
      items.add({
        'name': match.group(1)?.trim() ?? 'Unknown',
        'quantity': int.tryParse(match.group(2) ?? '1') ?? 1,
        'price': double.tryParse(match.group(3) ?? '0.0') ?? 0.0,
        'timestamp': Timestamp.now(),
      });
    }

    setState(() {
      _parsedItems = items;
    });
  }

  // Store parsed items in Firestore (under user's inventory)
  Future<void> _storeInFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please log in first')));
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    for (final item in _parsedItems) {
      final docRef = firestore.collection('users').doc(user.uid).collection('inventory').doc();
      batch.set(docRef, item);
    }

    await batch.commit();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Items added to inventory!')));
  }

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Receipt'),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan Receipt'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32)),
            ),
            const SizedBox(height: 20),
            if (_image != null) ...[
              Image.file(_image!, height: 200),
              const SizedBox(height: 20),
            ],
            if (_isProcessing) const Center(child: CircularProgressIndicator()),
            if (_extractedText.isNotEmpty) ...[
              const Text('Extracted Text:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_extractedText),
              const SizedBox(height: 20),
            ],
            if (_parsedItems.isNotEmpty) ...[
              const Text('Parsed Items:', style: TextStyle(fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _parsedItems.length,
                itemBuilder: (context, index) {
                  final item = _parsedItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Qty: ${item['quantity']} | Price: \$${item['price']}'),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}