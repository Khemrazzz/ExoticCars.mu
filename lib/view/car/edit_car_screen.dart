import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/services/storage_service.dart';

class EditCarScreen extends StatefulWidget {
  final Map<String, dynamic> car;
  const EditCarScreen({super.key, required this.car});

  @override
  State<EditCarScreen> createState() => _EditCarScreenState();
}

class _EditCarScreenState extends State<EditCarScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _brand;
  late TextEditingController _model;
  late TextEditingController _year;
  late TextEditingController _price;
  late TextEditingController _features;
  File? _imageFile;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _brand = TextEditingController(text: widget.car['brand']?.toString() ?? '');
    _model = TextEditingController(text: widget.car['model']?.toString() ?? '');
    _year = TextEditingController(text: widget.car['year']?.toString() ?? '');
    _price = TextEditingController(text: widget.car['price']?.toString() ?? '');
    _features = TextEditingController(text: widget.car['features']?.toString() ?? '');
  }

  @override
  void dispose() {
    _brand.dispose();
    _model.dispose();
    _year.dispose();
    _price.dispose();
    _features.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> updateCar() async {
    if (!_formKey.currentState!.validate()) return;
    final supabase = Supabase.instance.client;
    String? imageUrl = widget.car['image_url'];
    if (_imageFile != null) {
      final uploaded = await StorageService.uploadCarImage(_imageFile!);
      if (uploaded != null) imageUrl = uploaded;
    }
    final response = await supabase.from('cars').update({
      'brand': _brand.text.trim(),
      'model': _model.text.trim(),
      'year': int.parse(_year.text.trim()),
      'price': double.parse(_price.text.trim()),
      'features': _features.text.trim(),
      'image_url': imageUrl,
    }).eq('id', widget.car['id']);

    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Car updated')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error!.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Car')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _brand,
                decoration: const InputDecoration(labelText: 'Brand'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _model,
                decoration: const InputDecoration(labelText: 'Model'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _year,
                decoration: const InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _price,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _features,
                decoration: const InputDecoration(labelText: 'Features'),
              ),
              const SizedBox(height: 16),
              if (_imageFile != null)
                Image.file(_imageFile!, height: 150)
              else if (widget.car['image_url'] != null)
                Image.network(widget.car['image_url'], height: 150)
              else
                const SizedBox.shrink(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text('Change Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateCar,
                child: const Text('Update Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
