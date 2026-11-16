import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/login_screen.dart';


void main() {
  runApp(const AplikasiPiano());
}

class AplikasiPiano extends StatelessWidget {
  const AplikasiPiano({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eltera Piano',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      // Rute awal
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}