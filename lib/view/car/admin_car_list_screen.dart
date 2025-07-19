import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'edit_car_screen.dart';

class AdminCarListScreen extends StatefulWidget {
  const AdminCarListScreen({super.key});

  @override
  State<AdminCarListScreen> createState() => _AdminCarListScreenState();
}

class _AdminCarListScreenState extends State<AdminCarListScreen> {
  final client = Supabase.instance.client;
  List<Map<String, dynamic>> _cars = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    final response = await client.from('cars').select().order('created_at', ascending: false);

    if (response != null) {
      setState(() {
        _cars = List<Map<String, dynamic>>.from(response);
        _loading = false;
      });
    }
  }

  Future<void> deleteCar(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Car'),
        content: const Text('Are you sure you want to delete this car?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirm != true) return;

    final response = await client.from('cars').delete().eq('id', id);

    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Car deleted.')),
      );
      fetchCars();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error!.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin: Car List')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cars.length,
              itemBuilder: (context, index) {
                final car = _cars[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: car['image_url'] != null
                        ? Image.network(car['image_url'], width: 60, height: 60, fit: BoxFit.cover)
                        : const Icon(Icons.directions_car),
                    title: Text('${car['brand']} ${car['model']}'),
                    subtitle: Text('\$${car['price']} • ${car['year']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditCarScreen(car: car),
                          ),
                        );
                        fetchCars();
                      },
                    ),
                    onLongPress: () => deleteCar(car['id']),
                  ),
                );
              },
            ),
    );
  }
}
