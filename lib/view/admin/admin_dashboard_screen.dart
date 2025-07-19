import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.push('/admin-cars'),
          child: const Text('Manage Cars'),
        ),
      ),
    );
  }
}
