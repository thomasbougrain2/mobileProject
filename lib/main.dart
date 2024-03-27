import 'package:flutter/material.dart';
import 'screens/main_screen.dart'; // Assurez-vous que le chemin est correct
import 'theme/app_theme.dart'; // Importez le fichier du thème

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votre titre d\'application',
      theme: AppTheme.theme, // Utilisez le thème ici
      home: MainScreen(),
    );
  }
}
