import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _priceController = TextEditingController();
  final _featuresController = TextEditingController();
  File? _selectedImage;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<String?> uploadImage(File file) async {
    final storage = Supabase.instance.client.storage.from('car-images');
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${basename(file.path)}';

    final response = await storage.upload(fileName, file);

    if (response.isEmpty) {
      return null;
    }

    final publicUrl = storage.getPublicUrl(fileName);
    return publicUrl;
  }

  Future<void> addCar() async {
    if (!_formKey.currentState!.validate() || _selectedImage == null) return;

    final imageUrl = await uploadImage(_selectedImage!);
    if (imageUrl == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image upload failed')));
      return;
    }

    final response = await Supabase.instance.client.from('cars').insert({
      'brand': _brandController.text.trim(),
      'model': _modelController.text.trim(),
      'year': int.parse(_yearController.text),
      'price': double.parse(_priceController.text),
      'features': _featuresController.text.trim(),
      'image_url': imageUrl,
    });

    if (response != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Car added successfully')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Car')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: 'Brand'),
                    validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _modelController,
                    decoration: const InputDecoration(labelText: 'Model'),
                    validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Year'),
                    validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Price'),
                    validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _featuresController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Features')),
                const SizedBox(height: 16),
                _selectedImage != null
                    ? Image.file(_selectedImage!, height: 150)
                    : const Text('No image selected'),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Pick Image'),
                  onPressed: pickImage,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: addCar,
                  child: const Text('Add Car'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
