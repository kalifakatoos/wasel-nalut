// main.dart — Driver Captain App Entrypoint
import 'package:flutter/material.dart';
import 'driver_home_screen.dart';

void main() {
  runApp(const WaselDriverApp());
}

class WaselDriverApp extends StatelessWidget {
  const WaselDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasel Driver • كابتن واصل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        fontFamily: 'Tajawal',
      ),
      home: const DriverHomeScreen(),
    );
  }
}
