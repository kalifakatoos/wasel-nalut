// main.dart — Customer Super-App Entrypoint
import 'package:flutter/material.dart';
import 'design_system.dart';
import 'home_screen.dart';

void main() {
  runApp(const WaselCustomerApp());
}

class WaselCustomerApp extends StatelessWidget {
  const WaselCustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasel Nalut • واصل نالوت',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
