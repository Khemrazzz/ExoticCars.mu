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
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-maurice-lustig-1475620-2896135.jpg',
      'brand': 'Lamborghini',
      'model': 'Aventador',
      'year': 2022,
      'price': 25000000,
      'features': ['V12 Engine', 'Carbon Fiber', 'Auto Spoiler']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-caspersomia-13437208.jpg',
      'brand': 'Ferrari',
      'model': '488 GTB',
      'year': 2021,
      'price': 23000000,
      'features': ['Turbocharged', 'Leather Interior', 'Apple CarPlay']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-dante-juhasz-62201650-12964186.jpg',
      'brand': 'Bugatti',
      'model': 'Chiron Super Sport',
      'year': 2023,
      'price': 400000000,
      'features': ['Quad Turbo W16', 'Top Speed 490km/h', 'Carbon Ceramic Brakes']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-kindelmedia-9800029.jpg',
      'brand': 'Tesla',
      'model': 'Roadster',
      'year': 2023,
      'price': 25000000,
      'features': ['All-Electric', '0-100km/h in 1.9s', 'Glass Roof']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//Image.jpeg',
      'brand': 'Lucid Motors',
      'model': 'Air Dream Edition',
      'year': 2023,
      'price': 18000000,
      'features': ['520-mile Range', 'Luxury Interior', '21-speaker Audio']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//Image%201.jpeg',
      'brand': 'Rimac',
      'model': 'Nevera',
      'year': 2023,
      'price': 30000000,
      'features': ['1914 HP', '0–100 km/h in 1.85s', 'Fully Electric']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-lynxexotics-3764984.jpg',
      'brand': 'Rolls-Royce',
      'model': 'Ghost',
      'year': 2023,
      'price': 30000000,
      'features': ['V12 Engine', 'Starlight Headliner', 'Coach Doors']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-sebastianpichard-18776099.jpg',
      'brand': 'Bentley',
      'model': 'Continental GT',
      'year': 2023,
      'price': 22000000,
      'features': ['W12 Engine', '360 Camera', 'Heated Massage Seats']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-mathieu-gervais-95409679-11941023.jpg',
      'brand': 'Nissan',
      'model': 'GT-R NISMO',
      'year': 2022,
      'price': 18000000,
      'features': ['Twin-Turbo V6', 'Carbon Trim', 'Launch Control']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-egeardaphotos-2148533277-33032774.jpg',
      'brand': 'BMW',
      'model': 'M8 Competition',
      'year': 2023,
      'price': 15000000,
      'features': ['xDrive AWD', '4.4L V8', 'M Adaptive Suspension']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-mohit-hambiria-92377455-30513638.jpg',
      'brand': 'Mercedes-Benz',
      'model': 'AMG GT R',
      'year': 2022,
      'price': 20000000,
      'features': ['BiTurbo V8', 'Race Mode', 'Panamericana Grille']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//Image%202.jpeg',
      'brand': 'Porsche',
      'model': '911 Turbo S',
      'year': 2023,
      'price': 22000000,
      'features': ['Twin-Turbo Flat-6', 'Launch Control', 'PDK Transmission']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//pexels-gregory-costa-5733734.jpg',
      'brand': 'Audi',
      'model': 'R8 V10 Performance',
      'year': 2022,
      'price': 19000000,
      'features': ['V10 Engine', 'Quattro AWD', 'Virtual Cockpit']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//Image%203.jpeg',
      'brand': 'Lexus',
      'model': 'LFA',
      'year': 2012,
      'price': 28000000,
      'features': ['V10 Screamer', 'Carbon Chassis', 'Limited Edition']
    }
  ];

  @override
  Widget build(BuildContext context) {
    final isAdmin =
        Supabase.instance.client.auth.currentUser?.userMetadata?['is_admin'] ==
            true;
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
          if (isAdmin)
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
          ),
        ],
      ),
    );
  }
}
