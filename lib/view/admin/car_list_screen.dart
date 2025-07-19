import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final _client = Supabase.instance.client;
  List<Map<String, dynamic>> _cars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    final response = await _client.from('cars').select('*');
    setState(() {
      _cars = List<Map<String, dynamic>>.from(response);
      _isLoading = false;
    });
  }

  void goToEditCar(Map<String, dynamic> car) {
    // Navigate to your EditCarScreen (to be created next)
    // Navigator.push(context, MaterialPageRoute(builder: (_) => EditCarScreen(car: car)));
  }

  Future<void> deleteCar(String id) async {
    await _client.from('cars').delete().eq('id', id);
    fetchCars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Car deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Cars')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cars.length,
              itemBuilder: (context, index) {
                final car = _cars[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: car['image_url'] != null
                        ? Image.network(car['image_url'], width: 80, fit: BoxFit.cover)
                        : const Icon(Icons.directions_car),
                    title: Text(car['name'] ?? 'Unknown'),
                    subtitle: Text(car['price'] != null ? 'Rs ${car['price']}' : ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => goToEditCar(car),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteCar(car['id']),
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
