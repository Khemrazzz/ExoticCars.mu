import '../models/car_model.dart';

/// Sample list of cars displayed within the application.
final List<CarModel> carData = [
  CarModel(
    id: '1',
    brand: 'Lamborghini',
    model: 'Aventador',
    year: 2022,
    price: 25000000,
    imageUrl:
        'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images/aventador.jpg',
    features: const ['V12 Engine', 'Carbon Fiber', 'Auto Spoiler'],
  ),
  CarModel(
    id: '2',
    brand: 'Ferrari',
    model: '488 GTB',
    year: 2021,
    price: 23000000,
    imageUrl:
        'https://hftpatgseznkfbrrtcuf.supabase.co/storage/v1/object/public/car-images/488gtb.jpg',
    features: const ['Turbocharged', 'Leather Interior', 'Apple CarPlay'],
  ),
];
