import 'package:flutter/material.dart';
import 'screens/main_screen.dart'; // Assurez-vous d'importer correctement le fichier main_screen.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votre titre d\'application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(), // Remplacez MyHomePage() par MainScreen()
    );
  }
}
