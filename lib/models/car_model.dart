class CarModel {
  final String id;
  final String brand;
  final String model;
  final int year;
  final int price;
  final String imageUrl;
  final List<String> features;

  const CarModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    required this.imageUrl,
    this.features = const [],
  });

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] as String,
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as int,
      price: map['price'] as int,
      imageUrl: map['image_url'] as String,
      features: List<String>.from(map['features'] ?? const []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': year,
      'price': price,
      'image_url': imageUrl,
      'features': features,
    };
  }
}
