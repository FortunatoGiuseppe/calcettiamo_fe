import 'package:flutter/material.dart'; // Modificato da cupertino a material
import 'login.dart';
import 'friends_page.dart';
import 'admin_dashboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Convertito a MaterialApp per uno stile più moderno e cross-platform
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcettiamo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
    );
  }
}
