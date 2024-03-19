import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Assurez-vous de créer ce fichier dans le dossier screens

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ComicVine Explorer',
      theme: ThemeData(
        textTheme: TextTheme(
          // Utilisez le style par défaut pour le texte corporel
          bodyText2: TextStyle(fontFamily: 'Nunito'),
          // Ajoutez d'autres styles de texte selon vos besoins
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      // Ajoutez d'autres routes pour la navigation ici
    );
  }
}

