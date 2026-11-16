import 'package:flutter/material.dart';

class MuridDashboard extends StatelessWidget {
  const MuridDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF212529),
        title: const Text('Eltera - Panel Murid', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🎼', style: TextStyle(fontSize: 50)),
            Text('Selamat Datang di Eltera', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Di sini kamu bisa melihat jadwal dan catatan lagu kamu.'),
          ],
        ),
      ),
    );
  }
}