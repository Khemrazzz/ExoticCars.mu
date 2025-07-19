import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/auth_service.dart';
import '../../core/constants/color_scheme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logout(BuildContext context) async {
    await AuthService.signOut();
    context.go('/login');
  }

  final List<Map<String, dynamic>> cars = const [
    {
      'image':
      'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//aventador.jpg',
      'brand': 'Lamborghini',
      'model': 'Aventador',
      'year': 2022,
      'price': 25000000,
      'features': ['V12 Engine', 'Carbon Fiber', 'Auto Spoiler']
    },
    {
      'image':
      'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//aventador.jpg',
      'brand': 'Ferrari',
      'model': '488 GTB',
      'year': 2021,
      'price': 23000000,
      'features': ['Turbocharged', 'Leather Interior', 'Apple CarPlay']
    },
    // Add more cars if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Exotic Cars'),
        backgroundColor: AppColors.background,
        foregroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                context.push('/admin-cars');
              },
              child: const Text('Manage Cars'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return GestureDetector(
                  onTap: () {
                    context.push('/car/$index', extra: car);
                  },
                child: Card(
              color: AppColors.surface,
              margin: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      car['image'],
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${car['brand']} ${car['model']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${car['year']} • Rs ${car['price']}',
                          style: const TextStyle(color: Colors.amberAccent),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
