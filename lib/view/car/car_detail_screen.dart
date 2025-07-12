import 'package:flutter/material.dart';
import '../quote/request_quote_screen.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/constants/color_scheme.dart';

class CarDetailScreen extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('${car['brand']} ${car['model']}'),
        backgroundColor: AppColors.background,
        foregroundColor: Colors.amber,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              car['image'],
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${car['brand']} ${car['model']}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${car['year']} • Rs ${car['price']}',
            style: const TextStyle(color: Colors.amberAccent, fontSize: 18),
          ),
          const SizedBox(height: 20),
          const Text(
            'Features',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            (car['features'] as List).length,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.amber, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    car['features'][index],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: 'Request Quote',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RequestQuoteScreen(
                    carName: '${car['brand']} ${car['model']}',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
