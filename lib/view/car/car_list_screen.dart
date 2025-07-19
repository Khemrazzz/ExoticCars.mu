import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_scheme.dart';
import 'car_detail_screen.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  final List<Map<String, dynamic>> cars = const [
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//aventador.jpg',
      'brand': 'Lamborghini',
      'model': 'Aventador',
      'year': 2022,
      'price': 25000000,
      'features': ['V12 Engine', 'Carbon Fiber', 'Auto Spoiler']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//488gtb.jpg',
      'brand': 'Ferrari',
      'model': '488 GTB',
      'year': 2021,
      'price': 23000000,
      'features': ['Turbocharged', 'Leather Interior', 'Apple CarPlay']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//chiron.jpg',
      'brand': 'Bugatti',
      'model': 'Chiron Super Sport',
      'year': 2023,
      'price': 400000000,
      'features': ['Quad Turbo W16', 'Top Speed 490km/h', 'Carbon Ceramic Brakes']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//roadster.jpg',
      'brand': 'Tesla',
      'model': 'Roadster',
      'year': 2023,
      'price': 25000000,
      'features': ['All-Electric', '0-100km/h in 1.9s', 'Glass Roof']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//lucid_air.jpg',
      'brand': 'Lucid Motors',
      'model': 'Air Dream Edition',
      'year': 2023,
      'price': 18000000,
      'features': ['520-mile Range', 'Luxury Interior', '21-speaker Audio']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//rimac_nevera.jpg',
      'brand': 'Rimac',
      'model': 'Nevera',
      'year': 2023,
      'price': 30000000,
      'features': ['1914 HP', '0–100 km/h in 1.85s', 'Fully Electric']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//ghost.jpg',
      'brand': 'Rolls-Royce',
      'model': 'Ghost',
      'year': 2023,
      'price': 30000000,
      'features': ['V12 Engine', 'Starlight Headliner', 'Coach Doors']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//continental_gt.jpg',
      'brand': 'Bentley',
      'model': 'Continental GT',
      'year': 2023,
      'price': 22000000,
      'features': ['W12 Engine', '360 Camera', 'Heated Massage Seats']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//gtr.jpg',
      'brand': 'Nissan',
      'model': 'GT-R NISMO',
      'year': 2022,
      'price': 18000000,
      'features': ['Twin-Turbo V6', 'Carbon Trim', 'Launch Control']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//m8.jpg',
      'brand': 'BMW',
      'model': 'M8 Competition',
      'year': 2023,
      'price': 15000000,
      'features': ['xDrive AWD', '4.4L V8', 'M Adaptive Suspension']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//amg_gt.jpg',
      'brand': 'Mercedes-Benz',
      'model': 'AMG GT R',
      'year': 2022,
      'price': 20000000,
      'features': ['BiTurbo V8', 'Race Mode', 'Panamericana Grille']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//porsche_911.jpg',
      'brand': 'Porsche',
      'model': '911 Turbo S',
      'year': 2023,
      'price': 22000000,
      'features': ['Twin-Turbo Flat-6', 'Launch Control', 'PDK Transmission']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//audi_r8.jpg',
      'brand': 'Audi',
      'model': 'R8 V10 Performance',
      'year': 2022,
      'price': 19000000,
      'features': ['V10 Engine', 'Quattro AWD', 'Virtual Cockpit']
    },
    {
      'image': 'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images//lexus_lfa.jpg',
      'brand': 'Lexus',
      'model': 'LFA',
      'year': 2012,
      'price': 28000000,
      'features': ['V10 Screamer', 'Carbon Chassis', 'Limited Edition']
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Exotic Cars'),
        backgroundColor: AppColors.background,
        foregroundColor: Colors.amber,
      ),
      body: ListView.builder(
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
